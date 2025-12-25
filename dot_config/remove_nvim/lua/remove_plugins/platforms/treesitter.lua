-- [nfnl] dot_config/remove_nvim/lua/remove_plugins/platforms/treesitter.fnl
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
	local dev_path = "~/Products/tree-sitter-actions"
	local lazy_path = (_G.vim.fn.stdpath("data") .. "/lazy/tree-sitter-actions")
	local parser_url
	if _G.vim.fn.isdirectory(_G.vim.fn.expand(dev_path)) == 1 then
		parser_url = dev_path
	else
		parser_url = lazy_path
	end
	parser_config.actions = { install_info = { url = parser_url, files = { "src/parser.c" } } }
	return vim.opt.runtimepath:prepend(parser_url)
end
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { { "ClearHeadToDo-Devs/tree-sitter-actions", dev = true } },
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
