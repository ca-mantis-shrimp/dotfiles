(_G.vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                                {:pattern :*.http
                                 :callback #(set _G.vim.bo.filetype :http)})

