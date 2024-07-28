return {
	{
		"alker0/chezmoi.vim",
	},

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

	{ "numToStr/Comment.nvim", opts = {} },
}
