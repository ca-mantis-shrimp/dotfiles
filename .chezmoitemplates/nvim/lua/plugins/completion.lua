-- [nfnl] Compiled from lua/plugins/completion.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	if _G.vim.fn.has("win32") or (_G.vim.fn.executable("make") == 0) then
		return nil
	else
		return "make install_jsregexp"
	end
end
local function _3_()
	return require("luasnip.loaders.from_vscode").lazy_load()
end
local function _4_()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})
	local function _5_(args)
		return luasnip.lsp_expand(args.body)
	end
	local function _6_()
		local _7_
		if luasnip.expand_or_locally_jumpable(-1) then
			_7_ = luasnip.jump(-1)
		else
			_7_ = nil
		end
		return _7_()
	end
	return cmp.setup({
		snippet = { expand = _5_ },
		completion = { completeopt = ":menu,menuone,noinsert" },
		mapping = cmp.mapping.preset.insert({
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete({}),
			["<C-l>"] = cmp.mapping(_6_, { "i", "s" }),
		}),
		sources = {
			{ name = "copilot", group_index = 2 },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "conjure" },
			{ name = "codecompanion" },
			{ name = "render-markdown" },
		},
	})
end
return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = _1_, dependencies = { { "rafamadriz/friendly-snippets", config = _3_ } } },
			{
				"zbirenbaum/copilot-cmp",
				config = true,
				dependencies = { { "zbirenbaum/copilot.lua", config = true } },
				opts = { suggestion = { enabled = false }, panel = { enabled = false } },
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"Paterjason/cmp-conjure",
		},
		config = _4_,
	},
}
