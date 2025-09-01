-- [nfnl] plugins/platforms/mini.fnl
local function _1_()
	require("mini.ai").setup({ n_lines = 500 })
	require("mini.surround").setup()
	require("mini.statusline").setup()
	require("mini.files").setup()
	require("mini.pick").setup()
	return require("mini.sessions").setup()
end
local function _2_()
	return _G.MiniFiles.open()
end
return {
	"echasnovski/mini.nvim",
	version = "*",
	config = _1_,
	keys = { { "n", "<leader>F", _2_, { desc = "Open File Explorer" } } },
}
