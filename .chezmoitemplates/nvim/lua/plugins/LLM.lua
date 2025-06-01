-- [nfnl] lua/plugins/LLM.fnl
local function _1_()
	return os.getenv("HOME")
end
local function _2_()
	return require("copilot").setup({})
end
return {
	{
		"yetone/avante.nvim",
		even = "VeryLazy",
		opts = {
			provider = "ollama",
			cursor_applying_provider = "groq",
			ollama = { model = "deepseek-r1:latest" },
			behavior = { enable_cursor_planning_mode = true },
			vendors = {
				groq = {
					__inherited_from = "openai",
					api_key_name = "GROQ_API_KEY",
					endpoint = "https://api.groq.com/openai/v1/",
					model = "llama-3.3-70b-versatile",
					max_completion_tokens = 32768,
				},
			},
			rag_service = {
				enabled = true,
				host_mount = _1_,
				provider = "ollama",
				llm_model = "llama3",
				embed_model = "moic-embed-text",
				endpoint = "http://localhost:11434",
			},
		},
		build = "make",
		dependencies = {
			"HakonHarnes/img-clip.nvim",
			even = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = true,
					drag_and_drop = { insert_mode = true },
					prompt_for_file_name = false,
				},
				use_absolute_path = true,
			},
		},
		version = false,
	},
	{ "zbirenbaum/copilot.lua", config = _2_, cmd = "Copilot", event = "InsertEnter" },
	{ "olimorris/codecompanion.nvim", opts = {} },
}
