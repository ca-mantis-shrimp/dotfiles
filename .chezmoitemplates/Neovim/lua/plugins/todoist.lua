return {
	"ca-mantis-shrimp/Todoist.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"ca-manti-shrimp/treesitter-projects",
			dir = "~/Products/tree-sitter-projects/",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			build = function()
				local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

				parser_config.projects = {
					install_info = {
						url = "~/Products/tree-sitter-projects/",
						files = { "src/parser.c" },
					},
					filetype = "projects",
				}
			end,
		},
	},
	dir = "~/Products/Todoist.nvim",
	config = { api_key = vim.env.TODOIST_API_KEY },
}
