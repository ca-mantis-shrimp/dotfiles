-- [nfnl] Compiled from lua/plugins/LLM.fnl by https://github.com/Olical/nfnl, do not edit.
return {
	{
		"olimorris/codecompanion.nvim",
		lazy = true,
		keys = {
			{ "<leader>uc", "<cmd>CodeCompanionChat Toggle<CR>", desc = "[u]i to toggle code completion [c]hat" },
			{ "<leader>sA", "<cmd>CodeCompanionActions<CR>", desc = "[s]earch CodeCompanion [a]ctions" },
		},
		opts = { strategies = { chat = { adapter = "anthropic" }, inline = { adapter = "anthropic" } } },
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = { { "github/copilot.vim" } },
		build = "make tiktoken",
		opts = {},
	},
}
