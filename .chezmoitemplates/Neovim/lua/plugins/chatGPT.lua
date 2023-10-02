return {
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
}