-- [nfnl] plugins/libs.fnl
local function _1_()
	return require("which-key").show[{ global = false }]()
end
return {
	{ "folke/which-key.nvim", event = "VeryLazy", keys = { { "<leader>?", _1_ } } },
	{ "radenling/vim-dispatch-neovim", dependencies = { "tpope/vim-dispatch" } },
	{ "neovim/nvim-lspconfig", priority = 200 },
	{ "nvim-treesitter/nvim-treesitter", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "rcarriga/nvim-notify", lazy = true },
	{ "nvim-tree/nvim-web-devicons", config = true },
	{ "numToStr/Comment.nvim", config = true, lazy = true },
	{ "ravitemer/mcphub.nvim", lazy = true },
}
