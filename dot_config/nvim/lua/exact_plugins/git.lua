vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/sindrets/diffview.nvim",
})

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

require("neogit").setup()
vim.keymap.set("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "NeoGit" })
