local M = {
  state = {
    root = nil,
    git_dir = nil,
    session_path = nil,
  },
}

local group = vim.api.nvim_create_augroup("workspace-session", { clear = true })

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "workspace" })
end

local function normalize(path)
  return vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
end

local function run_git(args, cwd)
  local result = vim.system(vim.list_extend({ "git" }, args), { cwd = cwd, text = true }):wait()
  if result.code ~= 0 then
    return nil
  end

  local output = vim.trim(result.stdout)
  return output ~= "" and output or nil
end

local function path_dir(path)
  local stat = vim.uv.fs_stat(path)
  if stat and stat.type == "file" then
    return vim.fs.dirname(path)
  end

  return path
end

local function file_exists(path)
  return path and vim.uv.fs_stat(path) ~= nil
end

local function refresh_restored_buffers()
  vim.schedule(function()
    local current_tab = vim.api.nvim_get_current_tabpage()
    local current_win = vim.api.nvim_get_current_win()

    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      if vim.api.nvim_tabpage_is_valid(tab) then
        vim.api.nvim_set_current_tabpage(tab)

        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
          if vim.api.nvim_win_is_valid(win) then
            local buf = vim.api.nvim_win_get_buf(win)
            local name = vim.api.nvim_buf_get_name(buf)

            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "" and name ~= "" and vim.fn.filereadable(name) == 1 then
              vim.api.nvim_set_current_win(win)

              local view = vim.fn.winsaveview()
              local ok = pcall(vim.cmd, "silent edit")
              if ok then
                pcall(vim.fn.winrestview, view)
              end
            end
          end
        end
      end
    end

    if vim.api.nvim_tabpage_is_valid(current_tab) then
      vim.api.nvim_set_current_tabpage(current_tab)
    end

    if vim.api.nvim_win_is_valid(current_win) then
      vim.api.nvim_set_current_win(current_win)
    end
  end)
end

local function is_blank_buffer(buf)
  return vim.api.nvim_buf_get_name(buf) == ""
    and vim.bo[buf].buftype == ""
    and not vim.bo[buf].modified
    and vim.api.nvim_buf_line_count(buf) == 1
    and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
end

local function workspace_is_empty()
  if #vim.api.nvim_list_tabpages() > 1 then
    return false
  end

  if #vim.api.nvim_tabpage_list_wins(0) > 1 then
    return false
  end

  return is_blank_buffer(vim.api.nvim_get_current_buf())
end

local function modified_buffers()
  local buffers = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified then
      table.insert(buffers, buf)
    end
  end

  return buffers
end

local function confirm_save_modified()
  if #modified_buffers() == 0 then
    return true
  end

  local choice = vim.fn.confirm(
    "Save modified buffers before changing workspace?",
    "&Save\n&Discard\n&Cancel",
    1
  )

  if choice == 1 then
    local ok, err = pcall(vim.cmd, "wall")
    if not ok then
      notify(err, vim.log.levels.ERROR)
      return false
    end

    return true
  end

  return choice == 2
end

local function confirm_replace_workspace()
  if workspace_is_empty() then
    return true
  end

  return vim.fn.confirm("Replace current workspace?", "&Yes\n&No", 2) == 1
end

local function clear_workspace()
  vim.cmd("silent! tabnew")
  vim.cmd("silent! only")

  local fresh_tab = vim.api.nvim_get_current_tabpage()
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    if tab ~= fresh_tab and vim.api.nvim_tabpage_is_valid(tab) then
      vim.api.nvim_set_current_tabpage(tab)
      pcall(vim.cmd, "silent! tabclose!")
    end
  end

  if vim.api.nvim_tabpage_is_valid(fresh_tab) then
    vim.api.nvim_set_current_tabpage(fresh_tab)
  end

  local keep = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= keep and vim.api.nvim_buf_is_valid(buf) then
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end

  vim.cmd("silent! only")
end

local function set_active(root, git_dir)
  M.state.root = root
  M.state.git_dir = git_dir
  M.state.session_path = git_dir and vim.fs.joinpath(git_dir, "nvim", "session.vim") or nil
end

local function clear_active()
  M.state.root = nil
  M.state.git_dir = nil
  M.state.session_path = nil
end

local function prepare_transition(opts)
  opts = opts or {}

  if not confirm_save_modified() then
    return false
  end

  if opts.save_current and M.is_active() then
    M.save_session({ silent = true })
  end

  clear_workspace()
  return true
end

function M.find_repo_root(path)
  local dir = path_dir(normalize(path or vim.fn.getcwd()))
  local root = run_git({ "rev-parse", "--show-toplevel" }, dir)

  return root and normalize(root) or nil
end

function M.find_git_dir(path)
  local dir = path_dir(normalize(path or vim.fn.getcwd()))
  local git_dir = run_git({ "rev-parse", "--absolute-git-dir" }, dir)

  return git_dir and normalize(git_dir) or nil
end

function M.resolve(path)
  local root = M.find_repo_root(path)
  if not root then
    return nil
  end

  local git_dir = M.find_git_dir(path or root)
  if not git_dir then
    return nil
  end

  return {
    root = root,
    git_dir = git_dir,
    session_path = vim.fs.joinpath(git_dir, "nvim", "session.vim"),
  }
end

function M.is_active()
  return M.state.root ~= nil
end

function M.save_session(opts)
  opts = opts or {}
  if not M.is_active() then
    if not opts.silent then
      notify("no active project session to save", vim.log.levels.WARN)
    end
    return false
  end

  vim.fn.mkdir(vim.fs.dirname(M.state.session_path), "p")
  local ok, err = pcall(vim.cmd, "mksession! " .. vim.fn.fnameescape(M.state.session_path))
  if not ok then
    notify(err, vim.log.levels.ERROR)
    return false
  end

  if not opts.silent then
    notify("saved session to " .. M.state.session_path)
  end

  return true
end

function M.project_open(path, opts)
  opts = opts or {}

  if not path or path == "" then
    local fallback = M.find_repo_root(vim.fn.getcwd())
    if fallback then
      path = fallback
    else
      return M.pick_project()
    end
  end

  local target = M.resolve(path)
  if not target then
    notify("not inside a git project: " .. path, vim.log.levels.WARN)
    return false
  end

  if M.state.root == target.root then
    vim.cmd.cd(target.root)
    return true
  end

  local has_workspace = M.is_active() or not workspace_is_empty()
  if has_workspace then
    local should_prompt = opts.prompt_replace ~= false
    if should_prompt and not confirm_replace_workspace() then
      return false
    end

    if not prepare_transition({ save_current = M.is_active() }) then
      return false
    end
  end

  vim.cmd.cd(target.root)
  clear_active()

  if file_exists(target.session_path) then
    local ok, err = pcall(vim.cmd, "silent source " .. vim.fn.fnameescape(target.session_path))
    if not ok then
      notify(err, vim.log.levels.ERROR)
      return false
    end

    refresh_restored_buffers()
  end

  set_active(target.root, target.git_dir)
  return true
end

function M.project_switch(path)
  if not path or path == "" then
    return M.pick_project()
  end

  return M.project_open(path)
end

function M.project_close()
  if not M.is_active() and workspace_is_empty() then
    vim.cmd.cd(vim.fn.expand("~"))
    return true
  end

  if not confirm_replace_workspace() then
    return false
  end

  if not prepare_transition({ save_current = M.is_active() }) then
    return false
  end

  vim.cmd.cd(vim.fn.expand("~"))
  clear_active()
  return true
end

function M.session_quit()
  if not confirm_save_modified() then
    return false
  end

  if M.is_active() then
    M.save_session({ silent = true })
  end

  vim.cmd("wall")
  vim.cmd("qa")
  return true
end

function M.pick_project()
  local ok, snacks = pcall(require, "snacks")
  if not ok then
    notify("snacks.nvim is not available", vim.log.levels.ERROR)
    return false
  end

  snacks.picker.projects({
    confirm = function(picker, item)
      picker:close()
      if item and item.file then
        M.project_open(item.file)
      end
    end,
  })

  return true
end

function M.setup()
  vim.api.nvim_create_user_command("ProjectOpen", function(command)
    M.project_open(command.args)
  end, { nargs = "?", complete = "dir" })

  vim.api.nvim_create_user_command("ProjectSwitch", function(command)
    M.project_switch(command.args)
  end, { nargs = "?", complete = "dir" })

  vim.api.nvim_create_user_command("ProjectClose", function()
    M.project_close()
  end, {})

  vim.api.nvim_create_user_command("SessionSave", function()
    M.save_session()
  end, {})

  vim.api.nvim_create_user_command("SessionQuit", function()
    M.session_quit()
  end, {})

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = function()
      if vim.fn.argc() > 0 or vim.o.diff then
        return
      end

      local target = M.resolve(vim.fn.getcwd())
      if target and file_exists(target.session_path) then
        M.project_open(target.root, { prompt_replace = false })
      elseif target then
        vim.cmd.cd(target.root)
        set_active(target.root, target.git_dir)
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      if M.is_active() then
        M.save_session({ silent = true })
      end
    end,
  })
end

return M
