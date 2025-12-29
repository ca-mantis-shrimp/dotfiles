-- [nfnl] dot_config/remove_nvim/lua/remove_plugins/platforms/treesitter.fnl
local function _1_()
	require("nvim-treesitter.parsers")["actions"] =
		{ install_info = { path = "~/Products/tree-sitter-actions", queries = "queries" }, filetype = "actions" }
	return nil
end
return { "nvim-treesitter/nvim-treesitter", build = "TSUpdate", config = _1_, lazy = false }
