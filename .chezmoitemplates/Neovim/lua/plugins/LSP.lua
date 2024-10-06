-- [nfnl] Compiled from lua/plugins/LSP.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	local servers = {
		lua_ls = {
			settings = { Lua = { completion = { callSnippet = "Replace" }, diagnostics = { globals = { "vim" } } } },
		},
		fennel_ls = {},
		ruff_lsp = { init_options = { settings = { args = {} } } },
	}
	local ensure_installed = _G.vim.list_extend(_G.vim.tbl_keys((servers or {})), { "stylua" })
	local capabilities = _G.vim.tbl_deep_extend(
		"force",
		_G.vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	)
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	local function _2_(server_name)
		local server = (servers[server_name] or {})
		server["capabilities"] = _G.vim.tbl_deep_extend("force", {}, capabilities, (server.capabilities or {}))
		return require("lspconfig")[server_name].setup(server)
	end
	return require("mason-lspconfig").setup({ handlers = { _2_ } })
end
return {
	"neovim/nvim-lspconfig",
	priority = 0,
	dependencies = { "j-hui/fidget.nvim", "folke/neodev.nvim" },
	config = _1_,
}
