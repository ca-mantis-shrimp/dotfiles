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
			},
		},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionChat<CR>", desc = "CodeCompanion Chat" },
			{ "<leader>ci", "<cmd>CodeCompanionInline<CR>", mode = "v", desc = "CodeCompanion Inline" },
		},
	},
}
