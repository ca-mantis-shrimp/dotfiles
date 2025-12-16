-- [nfnl] plugins/LLM.fnl
local function _1_()
	return require("codecompanion.adapters").extend[{
		"claude_code",
		{ env = { CLAUDE_CODE_AUTH_TOKEN = "ANTHROPIC_API_KEY" } },
	}]
end
local function _2_()
	return (require("sidekick").nex_jump_or_apply() or "<tab>")
end
local function _3_()
	return require("sidekick.cli").toggle()
end
local function _4_()
	return require("sidekick.cli").select()
end
local function _5_()
	return require("sidekick.cli").close()
end
local function _6_()
	return require("sidekick.cli").send({ msg = "{this}" })
end
local function _7_()
	return require("sidekick.cli").send({ msg = "{file}" })
end
local function _8_()
	return require("sidekick.cli").send({ msg = "{selection}" })
end
local function _9_()
	return require("sidekick.cli").prompt()
end
local function _10_()
	return require("sidekick.cli").toggle({ name = "claude", focus = true })
end
return {
	{ "github/copilot.vim" },
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			{ "ravitemer/mcphub.nvim", build = "npm install -g mcp-hub@latest", opts = {} },
			{ "Davidyz/VectorCode", version = "*" },
		},
		opts = {
			interactions = {
				chat = { adapter = "anthropic" },
				inline = { adapter = "anthropic" },
				cmd = { adapter = "anthropic" },
			},
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_tools = true,
						show_server_tools_in_chat = true,
						show_result_in_chat = true,
						format_tool = nil,
						make_vars = true,
						make_slash_commands = true,
						add_mcp_prefix_to_tool_names = false,
					},
				},
				vectorcode = {
					opts = { tool_group = { enabled = true, extras = {}, collapse = false } },
					tool_opts = {
						["*"] = {},
						ls = {},
						vectorise = {},
						query = { max_num = { chunk = -1, document = -1 } },
						default_num = { chunk = 50, document = 10 },
						no_duplicate = true,
						summarize = { adapter = nil, query_argument = true, enabled = false },
						file_ls = {},
						files_rm = {},
						chunk_mode = false,
						include_stderr = false,
						use_lsp = false,
					},
				},
			},
			adapters = { acp = { claude_code = _1_ } },
			memory = { opts = { chat = { enabled = true } } },
		},
		keys = {
			{ "<leader>uc", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle [u]i for [c]ode companion" },
			{ "<leader>sC", "<cmd>CodeCompanionActions<CR>", desc = "[s]earch [C]odeCompanion Actions" },
			{ "ga", "<cmd>CodeCompanionChat Add<CR>", mode = "v", desc = "Add Current Selection to Chat" },
		},
	},
	{
		"folke/sidekick.nvim",
		opts = {},
		keys = {
			{ "<tab>", _2_, expr = true, desc = "Goto/Apply Next Edit Suggestions" },
			{ "<c-.>", _3_, desc = "Sidekick Toggle", mode = { "n", "t", "i", "x" } },
			{ "<leader>as", _4_, desc = "Select CLI" },
			{ "<leader>ad", _5_, desc = "detatch a CLI Session" },
			{ "<leader>at", _6_, mode = { "x", "n" }, desc = "Send This" },
			{ "<leader>af", _7_, mode = { "x", "n" }, desc = "Send File" },
			{ "<leader>av", _8_, mode = { "x", "n" }, desc = "Send Visual Selection" },
			{ "<leader>ap", _9_, mode = { "n", "x" }, desc = "Sidekick Select Prompt" },
			{ "<leader>ac", _10_, desc = "Sidekick Toggle Claude" },
		},
	},
}
