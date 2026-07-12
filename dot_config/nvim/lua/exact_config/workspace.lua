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

local function set_active(root, git_dir)
  M.state.root = root
  M.state.git_dir = git_dir
  M.state.session_path = vim.fs.joinpath(git_dir, "nvim", "session.vim")
end

local function clear_active()
  M.state.root = nil
  M.state.git_dir = nil
  M.state.session_path = nil
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
            if
              vim.api.nvim_buf_is_valid(buf)
              and vim.bo[buf].buftype == ""
              and name ~= ""
              and vim.fn.filereadable(name) == 1
            then
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

local function find_repo_root(path)
  local dir = path_dir(normalize(path or vim.fn.getcwd()))
  local root = run_git({ "rev-parse", "--show-toplevel" }, dir)
  return root and normalize(root) or nil
end

local function find_git_dir(path)
  local dir = path_dir(normalize(path or vim.fn.getcwd()))
  local git_dir = run_git({ "rev-parse", "--absolute-git-dir" }, dir)
  return git_dir and normalize(git_dir) or nil
end

function M.resolve(path)
  local root = find_repo_root(path)
  if not root then
    return nil
  end

  local git_dir = find_git_dir(path or root)
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

local function load_session(target)
  clear_active()

  if file_exists(target.session_path) then
    local ok, err = pcall(vim.cmd, "silent source " .. vim.fn.fnameescape(target.session_path))
    if not ok then
      notify(err, vim.log.levels.ERROR)
      return false
    end
    refresh_restored_buffers()
  else
    vim.cmd.cd(target.root)
  end

  set_active(target.root, target.git_dir)
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
      if not item or not item.file then
        return
      end

      local target = M.resolve(item.file)
      if not target or M.state.root == target.root then
        return
      end

      M.save_session({ silent = true })
      vim.cmd("silent! wall")
      vim.cmd("silent! tabonly")
      vim.cmd("silent! only")
      vim.cmd("silent! %bdelete!")

      load_session(target)
    end,
  })

  return true
end

function M.setup()
  vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"

  vim.api.nvim_create_user_command("ProjectSwitch", function()
    M.pick_project()
  end, {})

  vim.api.nvim_create_user_command("SessionSave", function()
    M.save_session()
  end, {})

  local ok, wk = pcall(require, "which-key")
  if ok then
    wk.add({
      { "<leader>w", group = "[w]orkspace" },
      { "<leader>wp", function() M.pick_project() end, desc = "Open [p]roject workspace" },
      { "<leader>ws", function() M.save_session() end, desc = "[s]ave workspace session" },
    })
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = function()
      if vim.fn.argc() > 0 or vim.o.diff then
        return
      end
      local target = M.resolve(vim.fn.getcwd())
      if target then
        load_session(target)
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      M.save_session({ silent = true })
    end,
  })
end

return M
