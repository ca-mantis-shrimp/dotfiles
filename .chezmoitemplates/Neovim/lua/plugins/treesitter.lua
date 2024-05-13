return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "python" },
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gsi",
				node_incremental = "gsn",
				scope_incremental = "gss",
				node_decremental = "gsd",
			},
		},
	},
	dependencies = {
		"ca-manti-shrimp/treesitter-projects",
		dir = "~/Products/tree-sitter-projects/",
	},

	config = function(_, opts)
		require("nvim-treesitter.install").prefer_git = true
		if vim.fn.has("win32") == 1 then
			require("nvim-treesitter.install").compilers = { "zig" }
		end
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		parser_config.projects = {
			install_info = {
				url = "~/Products/tree-sitter-projects/",
				files = { "src/parser.c" },
			},
			filetype = "projects",
		}
		---@diagnostic disable-next-line: missing-parameter
		require("nvim-treesitter.configs").setup(opts)
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
}
