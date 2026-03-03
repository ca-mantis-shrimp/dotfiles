-- [nfnl] dot_config/remove_nvim/lua/config/utils.fnl
local M = {}
local function _1_()
  return _G.vim.fn.has("win32")
end
M.is_windows = _1_
local function _2_()
  return _G.vim.fn.exists("g:vscode")
end
M.is_vscode = _2_
do
  local highlight
  local function _3_()
    return vim.treesitter.start()
  end
  highlight = _3_
  local folding
  local function _4_()
    local wo = vim.wo[0][0]
    wo["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
    wo["foldmethod"] = "expr"
    return nil
  end
  folding = _4_
  local indent
  local function _5_()
    vim.bo["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
    return nil
  end
  indent = _5_
  local function _6_()
    highlight()
    folding()
    return indent()
  end
  M.setup_treesitter = {highlight = highlight, folding = folding, indent = indent, full = _6_}
end
return M
