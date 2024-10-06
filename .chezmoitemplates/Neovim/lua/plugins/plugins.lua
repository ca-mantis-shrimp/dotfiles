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

	{ "rest-nvim/rest.nvim" },

	{ "akinsho/toggleterm.nvim", opts = { direction = "tab" } },
	{
		"Vigemus/iron.nvim",
		config = function()
			local iron = require("iron.core")

			iron.setup({
				config = {
					-- Whether a repl should be discarded or not
					scratch_repl = true,
					-- Your repl definitions come here
					repl_definition = {
						sh = {
							-- Can be a table or a function that
							-- returns a table (see below)
							command = { "zsh" },
						},
						python = {
							command = { "python3" }, -- or { "ipython", "--no-autoindent" }
							format = require("iron.fts.common").bracketed_paste_python,
						},
						lua = {
							command = { "lua" },
						},
						["lua.chezmoitmpl"] = { command = { "lua" } },
					},
					-- How the repl window will be displayed
					-- See below for more information
					repl_open_cmd = require("iron.view").bottom(40),
				},
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			})
		end,
	},
	{ "Olical/nfnl", ft = "fennel" },
	{ "Olical/conjure" },
}
