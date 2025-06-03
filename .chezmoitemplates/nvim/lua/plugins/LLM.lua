-- [nfnl] lua/plugins/LLM.fnl
local function _1_()
	return require("copilot").setup({})
end
return {
	{
		"yetone/avante.nvim",
		even = "VeryLazy",
		opts = { provider = "ollama", providers = { ollama = { model = "deepseek-r1:latest" } } },
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
	{ "zbirenbaum/copilot.lua", config = _1_, cmd = "Copilot", event = "InsertEnter" },
	{ "olimorris/codecompanion.nvim", opts = {} },
}
