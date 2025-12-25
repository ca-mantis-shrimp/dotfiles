[{:dir "~/Products/clearhead.nvim"
  :name :clearhead.nvim
  :dependencies [{1 :nvim-treesitter/nvim-treesitter} {1 :Olical/nfnl}]
  :ft :actions
  :cmd [:ClearheadInbox :ClearheadOpenDir]
  :config (fn []
            (let [clearhead (require :clearhead)]
              (clearhead.setup {})
              ;; Keymaps
              (vim.keymap.set :n :<leader>ti :<cmd>ClearheadInbox<CR>
                              {:desc "Open Clearhead inbox"})
              (vim.keymap.set :n :<leader>to :<cmd>ClearheadOpenDir<CR>
                              {:desc "Open .actions in current dir"})))}]

