local function _1_()
  return require("flash").jump()
end
local function _2_()
  return require("flash").treesitter()
end
local function _3_()
  return require("flash").remote()
end
local function _4_()
  return require("flash").treesitter_search()
end
local function _5_()
  return require("flash").toggle()
end
local function _6_()
  return require("smart-splits").move_cursor_left()
end
local function _7_()
  return require("smart-splits").move_cursor_down()
end
local function _8_()
  return require("smart-splits").move_cursor_up()
end
local function _9_()
  return require("smart-splits").move_cursor_right()
end
local function _10_()
  return require("smart-splits").resize_left()
end
local function _11_()
  return require("smart-splits").resize_down()
end
local function _12_()
  return require("smart-splits").resize_up()
end
local function _13_()
  return require("smart-splits").resize_right()
end
local function _14_()
  return require("smart-splits").swap_buf_left()
end
local function _15_()
  return require("smart-splits").swap_buf_down()
end
local function _16_()
  return require("smart-splits").swap_buf_up()
end
local function _17_()
  return require("smart-splits").swap_buf_right()
end
return {
  {
    "folke/flash.nvim",
    even = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>j", _1_, mode = { "n", "x", "o" } },
      { "<leader>J", _2_, mode = { "n", "x", "o" } },
      { "r", _3_, mode = "o" },
      { "R", _4_, mode = { "o", "x" } },
      { "<c-s>", _5_, mode = "c" },
    },
  },
  { "stevearc/oil.nvim", opts = {}, keys = { { "<leader>O", "<cmd>Oil<cr>", desc = "Open Oil" } } },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {},
    keys = {
      { "<c-h>", _6_ },
      { "<c-j>", _7_ },
      { "<c-k>", _8_ },
      { "<c-l>", _9_ },
      { "<A-h>", _10_ },
      { "<A-j>", _11_ },
      { "<A-k>", _12_ },
      { "<A-l>", _13_ },
      { "<leader><leader>h", _14_ },
      { "<leader><leader>j", _15_ },
      { "<leader><leader>k", _16_ },
      { "<leader><leader>l", _17_ },
    },
  },
}
