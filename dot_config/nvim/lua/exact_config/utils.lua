local M = {}

M.is_windows = function()
  return vim.fn.has("win32") == 1
end
M.is_vscode = function()
  return vim.fn.exists("g:vscode") == 1
end

local ts = {}

ts.highlight = function()
  vim.treesitter.start()
end

ts.folding = function()
  local wo = vim.wo[0][0]
  wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  wo.foldmethod = "expr"
end

ts.full = function()
  ts.highlight()
  ts.folding()
end

M.setup_treesitter = ts

return M
