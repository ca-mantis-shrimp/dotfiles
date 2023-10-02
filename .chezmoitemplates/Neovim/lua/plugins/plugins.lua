return {
  "cbochs/portal.nvim",
  dependencies = { "cbochs/grapple.nvim" },
  keys = {
    { "<leader>o", "<cmd>Portal jumplist backward<cr>" },
    { "<leader>i", "<cmd>Portal jumplist forward<cr>" },
  },
},

{
  "folke/noice.nvim",
  cond = not vim.g.started_by_firenvim,
},

{
  "ErichDonGubler/lsp_lines.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
    require("lsp_lines").setup()
  end,
  ft = { "lua", "python", "rust" },
},

{
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
},

{
  "alker0/chezmoi.vim",
},

{
  "jackMort/ChatGPT.nvim",
  config = function() 
    require('chatgpt').setup()
  end,
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
},

{
  "rest-nvim/rest.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  config = true
},

{
  "wfxr/minimap.vim",
  keys = { { "leader>um", "<cmd>MinimapToggle<cr>", desc = "Toggle Minimap" } },
  build = "cargo install --locked code-minimap",
  lazy = false,
},

{
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {},
    config = true
  },
},

{
  "weirongxu/plantuml-previewer.vim",
  dependencies = {"aklt/plantuml-syntax", "tyru/open-browser.vim"},
},

{"projekt0n/github-nvim-theme"},

{
  'cameron-wags/rainbow_csv.nvim',
  config = true,
  ft = {
    'csv',
    'tsv',
    'csv_semicolon',
    'csv_whitespace',
    'csv_pipe',
    'rfc_csv',
    'rfc_semicolon'
  },
  cmd = {
    'RainbowDelim',
    'RainbowDelimSimple',
    'RainbowDelimQuoted',
    'RainbowMultiDelim'
  }
}