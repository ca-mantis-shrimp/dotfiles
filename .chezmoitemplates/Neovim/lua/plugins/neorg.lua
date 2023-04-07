return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "nvim-neorg/neorg-telescope",
      {
        "folke/zen-mode.nvim",
        keys = { { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" } },
        config = true,
        dependencies = { "folke/twilight.nvim", config = true },
      },
    },
    ft = "norg",
    keys = {
      { "<leader>nt", "<cmd>Neorg journal today<cr>",            desc = "Today's Journal Page" },
      { "<leader>nw", "<cmd>Neorg workspace work_notes<cr>",     desc = "Edit Work Notes" },
      { "<leader>nm", "<cmd>Neorg workspace main<cr>",           desc = "Edit Primary Notes" },
      { "<leader>nk", "<cmd>Neorg workspace knowledge_base<cr>", desc = "Edit Knowledge Base" },
      { "<leader>nc", "<cmd>Neorg workspace config<cr>",         desc = "Edit Literate Configuration" },
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                main = "~/neorg",
                work_notes = "~/work_neorg_notes",
                knowledge_base = "~/knowledge_base",
                config = "~/.local/share/chezmoi/literate_config",
              },
              autochdir = true,
              index = "index.norg",
              last_workspace = vim.fn.stdpath("cache") .. "/neorg_last_workspace.txt",
            },
          },
          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode",
            },
          },
          ["core.norg.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.keybinds"] = {
            config = {
              neorg_leader = "<Leader>",
              hook = function(keybinds)
                keybinds.remap_key("norg", "n", "<C-s>", "<C-t>")
                keybinds.remap_key("norg", "i", "<C-l>", "<CS-l>")
                keybinds.map("norg", "n", "<leader>fn", "<cmd>Telescope neorg search_headings<CR>")
                keybinds.map("norg", "n", "<leader>nr", "<cmd>Neorg return<CR>")
              end,
            },
          },
          ["core.norg.qol.toc"] = {},
          ["core.norg.journal"] = {
            config = {
              journal_folder = "/journal/",
              use_folders = true,
              workspace = "main",
            },
          },
          ["core.norg.esupports.metagen"] = {
            config = {
              type = "auto",
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = {},
          ["core.integrations.telescope"] = {},
        },
      })
    end,
  },
}
