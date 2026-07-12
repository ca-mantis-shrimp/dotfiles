vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/folke/which-key.nvim",
})

require("which-key").setup()
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Show Buffer Keymaps" })
