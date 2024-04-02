local neorg_dependencies = {
  "nvim-treesitter/nvim-treesitter",
  "hrsh7th/nvim-cmp",
  "nvim-neorg/neorg-telescope",
  {
    "folke/zen-mode.nvim",
    keys = { { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" } },
    config = true,
    dependencies = { "folke/twilight.nvim", config = true },
  },
  { "luarocks.nvim" },
}

local lazy_loading_keymaps = {
  { "<leader>nt", "<cmd>Neorg journal today<cr>",            desc = "Today's Journal Page" },
  { "<leader>nw", "<cmd>Neorg workspace work_notes<cr>",     desc = "Edit Work Notes" },
  { "<leader>nm", "<cmd>Neorg workspace main<cr>",           desc = "Edit Primary Notes" },
  { "<leader>nk", "<cmd>Neorg workspace knowledge_base<cr>", desc = "Edit Knowledge Base" },
  { "<leader>nc", "<cmd>Neorg workspace config<cr>",         desc = "Edit Literate Configuration" },
  { "<leader>ns", "<cmd>Neorg generate-workspace-summary<cr>", desc = "Generate Workspace Summary" },
}
local norg_buffer_keymaps = {
  config = {
    neorg_leader = "<Leader>",
    hook = function(keybinds)
      keybinds.remap_key("norg", "n", "<C-s>", "<C-t>")
      keybinds.remap_key("norg", "i", "<C-l>", "<CS-l>")
      keybinds.map("norg", "n", "<leader>se", "<cmd>Telescope neorg search_headings<CR>")
      keybinds.map("norg", "n", "<leader>nr", "<cmd>Neorg return<CR>")
      keybinds.map("norg", "n", "<leader>nT", "<cmd>Neorg tangle current-file<CR>")
      keybinds.map("norg", "n", "<leader>ni", "<cmd>Neorg index<CR>")
    end,
  },
}


local dirman_configuration = {
  config = {
    workspaces = {
      main = "~/neorg",
      work_notes = "~/work_neorg_notes",
      knowledge_base = "~/knowledge_base",
      config = "~/.local/share/chezmoi/literate_config",
      journal = "~/journal"
    },
    autochdir = true,
    index = "index.norg",
    last_workspace = vim.fn.stdpath("cache") .. "/neorg_last_workspace.txt",
  },
}


local module_list = {
  ["core.defaults"] = {},
  ["core.concealer"] = {},
  ["core.dirman"] = dirman_configuration,
  ["core.presenter"] = {
    config = {
      zen_mode = "zen-mode",
    },
  },
  ["core.completion"] = {
    config = {
      engine = "nvim-cmp",
    },
  },
  ["core.keybinds"] = norg_buffer_keymaps,
  ["core.qol.toc"] = {},
  ["core.journal"] = {
    config = {
      journal_folder = "/years/",
      use_folders = true,
      workspace = "journal",
    },
  },
  ["core.esupports.metagen"] = {
    config = {
      type = "auto",
    },
  },
  ["core.export"] = {},
  ["core.export.markdown"] = {
    config = {
      extensions = "all"
    },
  },
  ["core.integrations.telescope"] = {},
  ["core.summary"] = {},
  ["core.ui.calendar"] = {},
}

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    dependencies = neorg_dependencies,
    ft = "norg",
    keys = lazy_loading_keymaps,
    config = function()
      require("neorg").setup({
        load = module_list,
      })
    end,
  },
}
