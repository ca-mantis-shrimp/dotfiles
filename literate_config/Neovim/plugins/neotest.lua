local activation_hotkeys = {
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
}

local dependencies_list = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "antoinemadec/FixCursorHold.nvim",
  "rouge8/neotest-rust",
  "nvim-neotest/neotest-python",
}
return {
  "nvim-neotest/neotest",
  keys = activation_hotkeys,
  dependencies = dependencies_list,
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python"),
        require("neotest-rust"),
      },
    })
  end,
}