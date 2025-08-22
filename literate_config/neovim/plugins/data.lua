-- [nfnl] neovim/plugins/data.fnl
return {
	{
		"cameron-wags/rainbow_csv.nvim",
		config = true,
		ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
		cmd = { "RainboxDelim", "RainboxDelimSimple", "RainboxDelimQuoted", "RainboxMultiDelim" },
	},
	{ "tpope/vim-dadbod" },
	{ "mistweaverco/kulala.nvim", ft = { "http", "rest" }, opts = { global_keymaps = true } },
}
