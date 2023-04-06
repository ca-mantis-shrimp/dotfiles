return {
  "neovim/nvim-lspconfig",
  dependencies = { "simrat39/rust-tools.nvim" },
  opts = {
    servers = {
      rust_analyzer = {},
    },
    setup = {
      tsserver = function(_, opts)
        require("lazyvim.util").on_attach(function(_, _) end)
        require("rust-tools").setup({ server = opts })
        return true
      end,
    },
  },
}
