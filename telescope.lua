local buku_telescope_plugin_spec = {
  "dhruvmanila/telescope-bookmarks.nvim",
  dependencies = { "kkharji/sqlite.lua", "tyru/open-browser.vim" },
  keys = { { "<leader>sB", "<cmd>Telescope bookmarks<cr>", desc = "Search Bookmarks" } },
}
local telescope_browser_setup_options = {
  selected_browser = "buku",
  url_open_plugin = "open_browser",
  buku_include_tags = true,
}
local load_bookmark_extension = function()
  require("telescope").load_extension("bookmarks")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim",
      buku_telescope_plugin_spec,
    },
    config = function()
      require("telescope").setup({
        extensions = {
          bookmarks = telescope_browser_setup_options,
        },
      })
      load_bookmark_extension()
    end,
  }
}