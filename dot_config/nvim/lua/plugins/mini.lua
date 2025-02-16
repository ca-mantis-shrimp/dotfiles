-- [nfnl] Compiled from lua/plugins/mini.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	require("mini.ai").setup({ n_lines = 500 })
	require("mini.surround").setup()
	require("mini.statusline").setup()
	require("mini.files").setup()
	require("mini.pick").setup()
	local function _2_()
		return MiniFiles.open()
	end
	return _G.vim.keymap.set("n", "<leader>F", _2_, { desc = "Open File Explorer" })
end
return { "echasnovski/mini.nvim", version = "*", config = _1_ }
