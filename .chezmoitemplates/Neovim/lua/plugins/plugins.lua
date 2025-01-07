-- [nfnl] Compiled from lua/plugins/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	local iron = require("iron.core")
	return iron.setup({
		config = {
			scratch_repl = true,
			repl_definition = {
				sh = { command = { "bash" } },
				python = { command = { "python3" }, format = iron.bracketed_paste_python },
				lua = { command = { "lua" } },
				["lua.chezmoitmpl"] = { command = { "lua" } },
			},
			repl_open_cmd = require("iron.view").bottom(40),
			highlight = { italic = true },
			ignore_blank_lines = true,
		},
	})
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
	{ "Vigemus/iron.nvim", config = _1_ },
	{ "Olical/nfnl", ft = "fennel" },
	{ "Olical/conjure" },
	{ "eraserhd/parinfer-rust", build = "cargo build --release", ft = { "fennel", "hy" } },
	{ "3rd/image.nvim", opts = {} },
}
