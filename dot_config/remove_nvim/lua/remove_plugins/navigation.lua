-- [nfnl] dot_config/remove_nvim/lua/remove_plugins/navigation.fnl
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
return {{"ThePrimeagen/harpoon", branch = "harpoon2", lazy = true, config = true}, {"folke/flash.nvim", even = "VeryLazy", opts = {}, keys = {{"<leader>j", _1_, mode = {"n", "x", "o"}}, {"<leader>J", _2_, mode = {"n", "x", "o"}}, {"r", _3_, mode = "o"}, {"R", _4_, mode = {"o", "x"}}, {"<c-s>", _5_, mode = "c"}}}, {"stevearc/oil.nvim", opts = {}, keys = {{"<leader>O", "<cmd>Oil<cr>", desc = "Open Oil"}}}}
