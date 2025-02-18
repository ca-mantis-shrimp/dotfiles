-- [nfnl] Compiled from lua/plugins/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	return not _G.vim.g.neovide
end
return {
	{ "alker0/chezmoi.vim" },
	{ "weirongxu/plantuml-previewer.vim", dependencies = { "aklt/plantuml-syntax", "tyru/open-browser.vim" } },
	{
		"cameron-wags/rainbow_csv.nvim",
		config = true,
		ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
		cmd = { "RainboxDelim", "RainboxDelimSimple", "RainboxDelimQuoted", "RainboxMultiDelim" },
	},
	{ "rest-nvim/rest.nvim" },
	{ "3rd/image.nvim", opts = { processor = "magick_cli" }, cond = _1_ },
}
