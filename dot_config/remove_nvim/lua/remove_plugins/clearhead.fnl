[{:dir "~/Products/platform/clearhead.nvim"
  :name :clearhead.nvim
  :dependencies [{1 :nvim-treesitter/nvim-treesitter} {1 :Olical/nfnl}]
  :ft :actions
  :cmd [:ClearheadInbox :ClearheadOpenDir]
  :config (fn []
            (let [clearhead (require :clearhead)]
              (clearhead.setup {})
              ;; File commands
              (vim.keymap.set :n :<leader>ti :<cmd>ClearheadInbox<CR>
                              {:desc "Open Clearhead inbox"})
              (vim.keymap.set :n :<leader>to :<cmd>ClearheadOpenDir<CR>
                              {:desc "Open .actions in current dir"})
              ;; State toggling - only in actions buffers
              (vim.api.nvim_create_autocmd :FileType
                                           {:pattern :actions
                                            :callback (fn []
                                                        ;; Cycle through states
                                                        (vim.keymap.set :n
                                                                        :<leader>tt
                                                                        clearhead.cycle-state
                                                                        {:buffer true
                                                                         :desc "Cycle task state"})
                                                        ;; Jump to specific states
                                                        (vim.keymap.set :n
                                                                        :<leader>tx
                                                                        (clearhead.set-state :x)
                                                                        {:buffer true
                                                                         :desc "Mark as completed"})
                                                        (vim.keymap.set :n
                                                                        :<leader>t-
                                                                        (clearhead.set-state "-")
                                                                        {:buffer true
                                                                         :desc "Mark as in-progress"})
                                                        (vim.keymap.set :n
                                                                        :<leader>t=
                                                                        (clearhead.set-state "=")
                                                                        {:buffer true
                                                                         :desc "Mark as blocked"})
                                                        (vim.keymap.set :n
                                                                        :<leader>t_
                                                                        (clearhead.set-state "_")
                                                                        {:buffer true
                                                                         :desc "Mark as cancelled"})
                                                        (vim.keymap.set :n
                                                                        :<leader>t<space>
                                                                        (clearhead.set-state " ")
                                                                        {:buffer true
                                                                         :desc "Mark as not started"}))})))}]

