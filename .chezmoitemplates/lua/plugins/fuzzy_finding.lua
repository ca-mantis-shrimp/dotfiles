return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          bookmarks = {
            selected_browser = "buku",
            url_open_plugin = "open_browser",
            buku_include_tags = true,
          },
          fzf = {},
        },
      })
    end,
  },

  "rudism/telescope-dict.nvim",

  {
    "dhruvmanila/telescope-bookmarks.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "kkharji/sqlite.lua", "tyru/open-browser.vim" },
    version = "1.*",
    keys = { { "<leader>sB", "<cmd>Telescope bookmarks<cr>", desc = "Search Bookmarks" } },
    config = function()
      require("telescope").load_extension("bookmarks")
    end,
  },

  {
    "mrjones2014/legendary.nvim",
    dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
    version = "2.*",
  },
}
