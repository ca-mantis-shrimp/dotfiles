-- [nfnl] plugins/platforms/mini.fnl
local function _1_()
	require("mini.ai").setup({ n_lines = 500 })
	require("mini.surround").setup()
	require("mini.statusline").setup()
	require("mini.sessions").setup()
	return require("mini.tabline").setup()
end
return { "echasnovski/mini.nvim", version = "*", config = _1_ }
