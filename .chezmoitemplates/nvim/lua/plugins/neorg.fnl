(let [dependencies [:nvim-neorg/neorg-telescope
                    {1 :folke/zen-mode.nvim
                     :keys [{1 :<leader>uz
                             2 :<cmd>ZenMode<cr>
                             :desc "Toggle Zen Mode"}]
                     :config true
                     :dependencies {1 :folke/twilight.nvim :config true}}]
      keys [{1 :<leader>nt
             2 "<cmd>Neorg journal today<cr>"
             :desc "Today's Journal Page"}
            {1 :<leader>nw
             2 "<cmd>Neorg workspace work_notes<cr>"
             :desc "Edit Work Notes"}
            {1 :<leader>nm
             2 "<cmd>Neorg workspace main<cr>"
             :desc "Edit Primary Notes"}
            {1 :<leader>nk
             2 "<cmd>Neorg workspace knowledge_base<cr>"
             :desc "Edit Knowledge Base"}
            {1 :<leader>nc
             2 "<cmd>Neorg workspace config<cr>"
             :desc "Edit Literate Config"}
            {1 :<leader>ns
             2 "<cmd>Neorg generate-workspace-summary<cr>"
             :desc "Generate Workspace Summary"}
            {1 :<leader>nr
             2 "<cmd>Neorg return<CR>"
             :desc "Return from Neorg Workspace"}
            {1 :<leader>nT
             2 "<cmd>Neorg tangle current-file<CR>"
             :desc "Tangle Current File"}
            {1 :<leader>ni
             2 "<cmd>Neorg index<CR>"
             :desc "Go to Index of Neorg Workspace"}
            {1 :<leader>se
             2 "<cmd>Telescope neorg search_headings<CR>"
             :desc "Search Headings"}]
      dirman_config {:config {:workspaces {:main "~/neorg"
                                           :work_notes "~/dab_work_neorg_notes"
                                           :knowledge_base "~/knowledge_base"
                                           :config "~/.local/share/chezmoi/literate_config"
                                           :journal "~/journal"}
                              :autochdir true
                              :index :index.norg
                              :last_workspace (.. (_G.vim.fn.stdpath :cache)
                                                  :/neorg_last_workspace.txt)}}
      load {:core.defaults {}
            :core.concealer {}
            :core.dirman dirman_config
            :core.presenter {:config {:zen_mode :zen-mode}}
            :core.completion {:config {:engine :nvim-cmp}}
            :core.qol.toc {}
            :core.journal {:config {:journal_folder :/years/
                                    :workspace :journal}}
            :core.esupports.metagen {:config {:type :auto}}
            :core.export {}
            :core.export.markdown {:config {:extensions :all}}
            :core.integrations.telescope {}
            :core.summary {}}]
  {1 :nvim-neorg/neorg : dependencies :lazy false : keys :opts {: load}})

