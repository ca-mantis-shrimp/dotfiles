-- [nfnl] plugins/platforms/treesitter.fnl
local function _1_(_, opts)
	require("nvim-treesitter.install")["prefer_git"] = true
	if _G.vim.fn.has("win32") == 1 then
		require("nvim-treesitter.install")["compilers"] = { "zig" }
	else
	end
	require("nvim-treesitter.configs").setup(opts)
	_G.vim.opt["foldmethod"] = "expr"
	_G.vim.opt["foldexpr"] = "nvim_treesitter#foldexpr()"
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.actions = {
		install_info = { url = (_G.vim.fn.stdpath("data") .. "/lazy/tree-sitter-actions"), files = { "src/parser.c" } },
	}
	return nil
end
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { { "ClearHeadToDo-Devs/tree-sitter-actions" } },
	opts = {
		ensure_installed = { "bash", "c", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "python" },
		auto_install = true,
		highlight = { enable = true },
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
	config = _1_,
}
