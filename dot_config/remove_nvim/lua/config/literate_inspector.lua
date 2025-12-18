-- [nfnl] dot_config/remove_nvim/lua/config/literate_inspector.fnl
local M = {}
M["find-chezmoi-root"] = function()
  local current_dir = vim.fn.getcwd()
  local markers = {".chezmoiignore", ".chezmoitemplates"}
  local search_path = vim.fs.find(markers, {upward = true, path = current_dir, type = "file"})
  if (search_path and (#search_path > 0)) then
    return vim.fn.fnamemodify(search_path[1], ":h")
  else
    vim.notify("Could not find chezmoi root directory", vim.log.levels.WARN)
    return nil
  end
end
M["get-tangle-path"] = function(norg_file)
  local lines = vim.fn.readfile(norg_file)
  local in_metadata = false
  local tangle_path = nil
  for _, line in ipairs(lines) do
    if line:match("^@document.meta") then
      in_metadata = true
    else
    end
    if (in_metadata and line:match("^tangle:")) then
      tangle_path = line:match("^tangle:%s*(.+)$")
    else
    end
    if line:match("^@end") then
      in_metadata = false
    else
    end
  end
  return tangle_path
end
M["resolve-tangle-path"] = function(norg_file, tangle_directive)
  local norg_dir = vim.fn.fnamemodify(norg_file, ":h")
  local combined = (norg_dir .. "/" .. tangle_directive)
  return vim.fn.fnamemodify(combined, ":p")
end
M["chezmoi-source-to-dest"] = function(source_path)
  local home = os.getenv("HOME")
  local patterns = {{"^.*/dot_(.+)%.tmpl$", (home .. "/%1")}, {"^.*/dot_(.+)$", (home .. "/.%1")}, {"^.*/dot_config/remove_(.+)%.tmpl$", (home .. "/.config/%1")}, {"^.*/dot_config/remove_(.+)$", (home .. "/.config/%1")}, {"^.*/AppData/Local/remove_(.+)%.tmpl$", (home .. "/AppData/Local/%1")}, {"^.*/AppData/Local/remove_(.+)$", (home .. "/AppData/Local/%1")}, {"^.*/dot_config/(.+)%.tmpl$", (home .. "/.config/%1")}, {"^.*/dot_config/(.+)$", (home .. "/.config/%1")}}
  local result = nil
  for _, _5_ in ipairs(patterns) do
    local pattern = _5_[1]
    local replacement = _5_[2]
    if not result then
      local transformed = source_path:gsub(pattern, replacement)
      if (transformed ~= source_path) then
        result = transformed
      else
      end
    else
    end
  end
  return result
end
M["trace-pipeline"] = function(norg_file)
  local result = {source = norg_file, steps = {}}
  local tangle_directive = M["get-tangle-path"](norg_file)
  if not tangle_directive then
    result.error = "No tangle directive found"
    return result
  else
    local tangle_path = M["resolve-tangle-path"](norg_file, tangle_directive)
    table.insert(result.steps, {stage = "tangle", file = tangle_path})
    if tangle_path:match("%.fnl$") then
      local lua_path = tangle_path:gsub("%.fnl$", ".lua")
      table.insert(result.steps, {stage = "compile", file = lua_path})
      tangle_path = lua_path
    else
    end
    do
      local root = M["find-chezmoi-root"]()
      local template_name = tangle_path:match(".*/%.chezmoitemplates/(.+)$")
      if (root and template_name) then
        local search_cmd = ("grep -r '\"" .. template_name .. "\"' " .. root .. "/dot_config " .. root .. "/AppData " .. "2>/dev/null | cut -d: -f1")
        local tmpl_files = vim.fn.systemlist(search_cmd)
        for _, tmpl_file in ipairs(tmpl_files) do
          local dest = M["chezmoi-source-to-dest"](tmpl_file)
          if dest then
            table.insert(result.steps, {stage = "template-ref", source = tmpl_file})
            table.insert(result.steps, {stage = "destination", file = dest})
          else
          end
        end
      else
      end
    end
    return result
  end
end
M["show-current-pipeline"] = function()
  local current_file = vim.api.nvim_buf_get_name(0)
  if not current_file:match("%.norg$") then
    return vim.notify("Not a .norg file", vim.log.levels.WARN)
  else
    local pipeline = M["trace-pipeline"](current_file)
    local lines = {("Pipeline for: " .. pipeline.source), ""}
    if pipeline.error then
      table.insert(lines, ("Error: " .. pipeline.error))
    else
      for _, step in ipairs(pipeline.steps) do
        local stage_name = step.stage:gsub("-", " ")
        table.insert(lines, ("  [" .. stage_name .. "] \226\134\146 " .. (step.file or step.source)))
      end
    end
    local buf = vim.api.nvim_create_buf(false, true)
    local width = 100
    local height = (#lines + 2)
    local row = math.floor(((vim.o.lines - height) / 2))
    local col = math.floor(((vim.o.columns - width) / 2))
    local opts = {relative = "editor", width = width, height = height, row = row, col = col, style = "minimal", border = "rounded", title = " Literate Config Pipeline ", title_pos = "center"}
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    return vim.keymap.set("n", "q", "<cmd>close<cr>", {buffer = buf})
  end
end
vim.api.nvim_create_user_command("InspectPipeline", M["show-current-pipeline"], {})
local function _14_()
  return vim.keymap.set("n", "<leader>ni", M["show-current-pipeline"], {buffer = true, desc = "Inspect literate config pipeline"})
end
vim.api.nvim_create_autocmd("FileType", {pattern = "norg", callback = _14_})
return M
