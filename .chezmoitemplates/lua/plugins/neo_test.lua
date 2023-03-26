return {
  "nvim-neotest/neotest",
  keys = {
    {
      "<leader>tS",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Neotest Summary",
    },
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Nearest Test",
    },

    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run Current File",
    },

    {
      "<leader>ts",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run Test Suite",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-python",
    "rouge8/neotest-rust",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
        }),
        require("neotest-rust"),
      },
    })
  end,
}
