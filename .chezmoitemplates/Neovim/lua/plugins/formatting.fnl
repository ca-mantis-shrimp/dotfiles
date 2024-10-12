{1 :stevearc/conform.nvim
 :lazy false
 :keys [{1 :<leader>f
         2 (fn []
             ((. (require :conform) :format) {:async true :lsp_fallback true}))
         :mode ""
         :desc "[Format] buffer"}]
:opts {:notify_on_error false :format_on_save (fn [bufnr]
                                               (let [disable_filetypes {:c true :cpp true}]
                                                 ({:timeout_ms 5000 lsp_fallback (not (. disable_filetyptes _G.vim.)})))}

