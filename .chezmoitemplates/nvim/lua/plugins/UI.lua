-- [nfnl] Compiled from lua/plugins/UI.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	return require("which-key").show({ global = false })
end
local function _2_()
	return ("Snacks.picker"):smart()
end
return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = { { "<leader>?", _1_, desc = "Buffer local keymaps (which-key)" } },
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		keys = { { "<leader><space>", _2_ } },
		lazy = false,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
	},
}
