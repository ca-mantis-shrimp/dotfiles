return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "octaltree/cmp-look",
      "hrsh7th/cmp-path",
      "Saecki/crates.nvim",
      "quangnguyen30192/cmp-nvim-tags",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "f3fora/cmp-spell",
      {
        "zbirenbaum/copilot-cmp",
        dependencies = {
          "zbirenbaum/copilot.lua",
          cmd = "Copilot",
          event = "InsertEnter",
          cond = not vim.g.started_by_firenvim,
          enabled = false,
          opts = { suggestion = { enabled = false }, panel = { enabled = false } },
        },
        config = true,
      },
    },
    config = function()
      local cmp = require("cmp")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = require("lspkind").cmp_format({
            with_text = true,
            maxwidth = 50,
            menu = {
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
              copilot = "[copilot]",
            },
            before = function(_, vim_item)
              return vim_item
            end,
          }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "neorg" },
          { name = "luasnip" },
          { name = "nvim-lua" },
          { name = "look" },
          { name = "tags" },
          { name = "crates" },
          { name = "path" },
          { name = "copilot" },
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
            },
          },
        }),
      })
      Cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    end,
  },
}
