(_G.vim.api.nvim_create_autocmd "FileType" {
                             :pattern ["norg"]
                             :callback (fn []
                                         (set _G.vim.opt_local.wrap true)
                                         (set _G.vim.opt_local.spell true)
                                         (set _G.vim.opt.spelllang ["en_us"]))
                                          })

(_G.vim.api.nvim_create_autocmd  "TextYankPost" {
                                :desc "highlight when yanking text"
                                :group (_G.vim.api.nvim_create_augroup "kickstart-highlight-yank" {:clear true})
                                :callback (fn []
                                            (_G.vim.highlight.on_yank))
                                })
