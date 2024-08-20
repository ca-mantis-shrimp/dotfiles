-- Important for tree-sitter parsers installed after the original plugin
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

parser_config.projects = {
	install_info = {
		url = "~/Products/tree-sitter-projects",
		files = { "src/parser.c" },
	},
	filetype = "projects",
}
