-- [nfnl] lua/plugins/UI.fnl
local function _1_()
	return require("which-key.show")({ global = false })
end
local function _2_()
	return _G.Snacks.picker.smart()
end
local function _3_()
	return _G.Snacks.picker.buffers()
end
local function _4_()
	return _G.Snacks.picker.grep()
end
local function _5_()
	return _G.Snacks.picker.command_history()
end
local function _6_()
	return _G.Snacks.picker.notifications()
end
local function _7_()
	return _G.Snacks.explorer()
end
local function _8_()
	return _G.Snacks.picker.registers()
end
local function _9_()
	return _G.Snacks.picker.help()
end
local function _10_()
	return _G.Snacks.picker.marks()
end
local function _11_()
	return _G.Snacks.picker.man()
end
local function _12_()
	return _G.Snacks.picker.keymaps()
end
local function _13_()
	return _G.Snacks.picker.commands()
end
local function _14_()
	return _G.Snacks.picker.icons()
end
local function _15_()
	return _G.Snacks.picker.jumps()
end
local function _16_()
	return _G.Snacks.picker.diagnostics()
end
local function _17_()
	return _G.Snacks.terminal()
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
		dependencies = { { "folke/persistence.nvim", event = "BufReadPre", opts = {} } },
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				sections = {
					{ section = "header" },
					{ icon = "\239\132\156", title = "Keymaps", section = "keys" },
					{ icon = "\238\153\129", title = "Recent Files", section = "recent_files" },
					{ icon = "\238\152\129", title = "Projects", section = "projects" },
					{ icon = "\239\130\160", section = "session", title = "Sessions" },
					{ section = "startup" },
				},
			},
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
		keys = {
			{ "<leader><space>", _2_, desc = "Smart Find Files" },
			{ "<leader>,", _3_, desc = "Search Buffers" },
			{ "<leader>/", _4_, desc = "Grep Files" },
			{ "<leader>:", _5_, desc = "Search Command History" },
			{ "<leader>N", _6_, desc = "Search Notifications" },
			{ "<leader>e", _7_, desc = "Open File Explorer" },
			{ '<leader>"', _8_, desc = "Search Registers" },
			{ "<leader>sh", _9_, desc = "Search Help Docs" },
			{ "<leader>sm", _10_, desc = "Search Marks" },
			{ "<leader>sM", _11_, desc = "Search Man Pages" },
			{ "<leader>sk", _12_, desc = "Search Keymaps" },
			{ "<leader>sc", _13_, desc = "Search Commands" },
			{ "<leader>si", _14_, desc = "Search Icons" },
			{ "<leader>sj", _15_, desc = "Search Jumps" },
			{ "<leader>sd", _16_, desc = "Search Diagnostics" },
			{ "<c-/>", _17_, desc = "Open Terminal" },
		},
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
