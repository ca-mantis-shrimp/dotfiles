-- [nfnl] plugins/LLM.fnl
return {
	{ "github/copilot.vim" },
	{ "CopilotC-Nvim/CopilotChat.nvim", build = "make tiktoken", opts = {} },
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		keys = {
			{ "<leader>cc", "<cmd>CodeCompanionChat<CR>", desc = "CodeCompanion Chat" },
			{ "<leader>ci", "<cmd>CodeCompanionInline<CR>", mode = "v", desc = "CodeCompanion Inline" },
		},
	},
}
