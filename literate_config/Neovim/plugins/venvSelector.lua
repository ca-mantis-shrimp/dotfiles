return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  config = true,
  keys = {
    {"<leader>vs", "<cmd>:VenvSelect<cr>"},
    {"<leader>vs", "<cmd>:VenvSelectCached<cr>"},
  }
}