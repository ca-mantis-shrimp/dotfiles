-- [nfnl] plugins/LLM.fnl
return {
	{ "github/copilot.vim" },
	{ "CopilotC-Nvim/CopilotChat.nvim", build = "make tiktoken", opts = {} },
	{
		"olimorris/codecompanion.nvim",
		dependencies = { { "ravitemer/mcphub.nvim", build = "npm install -g mcp-hub@latest", opts = {} } },
		opts = {
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
		},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionChat<CR>", desc = "CodeCompanion Chat" },
			{ "<leader>ci", "<cmd>CodeCompanionInline<CR>", mode = "v", desc = "CodeCompanion Inline" },
		},
	},
}
