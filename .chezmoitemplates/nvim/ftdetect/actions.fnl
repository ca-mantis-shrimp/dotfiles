(_G.vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                                {:pattern :*.actions
                                 :callback (fn []
                                             (set _G.vim.bo.filetype :actions))})

