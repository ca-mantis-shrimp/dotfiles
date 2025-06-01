-- [nfnl] lua/plugins/plugins.fnl
local function _1_()
	return require("chezmoi").setup({ edit = { watch = true } })
end
return {
	{ "xvzc/chezmoi.nvim", config = _1_ },
	{ "weirongxu/plantuml-previewer.vim", dependencies = { "aklt/plantuml-syntax", "tyru/open-browser.vim" } },
	{
		"cameron-wags/rainbow_csv.nvim",
		config = true,
		ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
		cmd = { "RainboxDelim", "RainboxDelimSimple", "RainboxDelimQuoted", "RainboxMultiDelim" },
	},
	{ "Davidyz/VectorCode" },
	{ "neovim/nvim-lspconfig" },
}
