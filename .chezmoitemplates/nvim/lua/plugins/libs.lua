-- [nfnl] lua/plugins/libs.fnl
return {
	{ "numToStr/Comment.nvim", config = true, lazy = true },
	{ "williamboman/mason.nvim", config = true, lazy = true },
	{ "williamboman/mason-lspconfig.nvim", lazy = true },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "stevearc/dressing.nvim", lazy = true },
	{ "nvim-treesitter/nvim-treesitter", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{ "rcarriga/nvim-notify", lazy = true },
	{ "nvim-tree/nvim-web-devicons", config = true },
	{ "radenling/vim-dispatch-neovim", dependencies = { "tpope/vim-dispatch" } },
	{ "ravitemer/mcphub.nvim", lazy = true },
}
