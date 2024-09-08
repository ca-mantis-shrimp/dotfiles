return {
	{
		"alker0/chezmoi.vim",
	},
	{ "nvim-lua/plenary.nvim", lazy = true },

	{
		"weirongxu/plantuml-previewer.vim",
		dependencies = { "aklt/plantuml-syntax", "tyru/open-browser.vim" },
	},

	{
		"cameron-wags/rainbow_csv.nvim",
		config = true,
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
		cmd = {
			"RainbowDelim",
			"RainbowDelimSimple",
			"RainbowDelimQuoted",
			"RainbowMultiDelim",
		},
	},

	"tpope/vim-sleuth",

	{ "numToStr/Comment.nvim", config = true },
	{ "rest-nvim/rest.nvim" },
	{ "williamboman/mason.nvim", config = true, lazy = true },
	{ "williamboman/mason-lspconfig.nvim", lazy = true },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = true },
	{ "akinsho/toggleterm.nvim", opts = { direction = "tab" } },
}
