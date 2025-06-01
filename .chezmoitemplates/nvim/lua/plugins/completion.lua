-- [nfnl] lua/plugins/completion.fnl
local function _1_()
	return require("copilot_cmp").setup()
end
local function _2_()
	if _G.vim.fn.has("win32") or (_G.vim.fn.executable("make") == 0) then
		return nil
	else
		return "make install_jsregexp"
	end
end
local function _4_()
	return require("luasnip.loaders.from_vscode").lazy_load()
end
local function _5_()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})
	local function _6_(args)
		return luasnip.lsp_expand(args.body)
	end
	local function _7_()
		local _8_
		if luasnip.expand_or_locally_jumpable(-1) then
			_8_ = luasnip.jump(-1)
		else
			_8_ = nil
		end
		return _8_()
	end
	return cmp.setup({
		snippet = { expand = _6_ },
		completion = { completeopt = ":menu,menuone,noinsert" },
		mapping = cmp.mapping.preset.insert({
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete({}),
			["<C-l>"] = cmp.mapping(_7_, { "i", "s" }),
		}),
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "conjure" },
			{ name = "codecompanion" },
			{ name = "render-markdown" },
			{ name = "copilot", group_index = 2 },
		},
	})
end
return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "zbirenbaum/copilot-cmp", config = _1_ },
			{ "L3MON4D3/LuaSnip", build = _2_, dependencies = { { "rafamadriz/friendly-snippets", config = _4_ } } },
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"Paterjason/cmp-conjure",
		},
		config = _5_,
	},
}
