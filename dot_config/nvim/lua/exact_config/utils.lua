local M = {}

M.is_windows = function()
  return vim.fn.has("win32") == 1
end
M.is_vscode = function()
  return vim.fn.exists("g:vscode") == 1
end

return M
