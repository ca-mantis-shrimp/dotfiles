-- [nfnl] Compiled from lua/plugins/UI.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	return require("which-key").show({ global = false })
end
local function _2_()
	return require("dashboard").setup({})
end
return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = { { "<leader>?", _1_, desc = "Buffer local keymaps (which-key)" } },
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opt = { sign = false },
	},
	{ "nvimdev/dashboard-nvim", event = "VimEnter", config = _2_, dependencies = { "nvim-tree/nvim-web-devicons" } },
}
