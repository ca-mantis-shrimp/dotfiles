[{1 :lewis6991/gitsigns.nvim
  :opts {:signs {:add {:text "+"}
                 :change {:text "~"}
                 :delete {:text "_"}
                 :topdelete {:text "‾"}
                 :changedelete {:text "~"}}}}
 {1 :NeogitOrg/neogit
  :dependencies [:nvim-lua/plenary.nvim
                 :sindrets/diffview.nvim
                 :nvim-telescope/telescope.nvim]
  :config true
  :keys [{1 :<leader>g 2 :<cmd>Neogit<CR> :desc :NeoGit}]}]
