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
local function _3_()
	return _G.vim.treesitter.start()
end
M.setup_treesitter_highlight = _3_
local function _4_()
	local wo = vim.wo[0][0]
	wo["foldexpr"] = "v:lua.vim.treesitter.foldexpr()"
	wo["foldmethod"] = "expr"
	return nil
end
M.setup_treesitter_folding = _4_
local function _5_()
	vim.bo["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
	return nil
end
M.setup_treesitter_indentation = _5_
local function _6_()
	M.setup_treesitter_highlight()
	M.setup_treesitter_folding()
	return M.setup_treesitter_indentation()
end
M.setup_treesitter_full = _6_
return M
