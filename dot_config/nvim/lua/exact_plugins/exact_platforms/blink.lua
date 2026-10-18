vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/rafamadriz/friendly-snippets",
})

local cmp = require("blink.cmp")

cmp.setup({
  keymap = {
    preset = "default",
    ["<Tab>"] = {
      "snippet_forward",
      function() return require("sidekick").nes_jump_or_apply() end,
      function() return vim.lsp.inline_completion.get() end,
      "fallback",
    },
  },
  appearance = { nerd_font_variant = "mono" },
  completion = { documentation = { auto_show = false } },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  fuzzy = { implementation = "lua" },
})
