{1 :nvim-neotest/neotest
 :dependencies [:nvim-neotest/nvim-nio
                :antoinemadec/FixCursorHold.nvim
                :nvim-neotest/neotest-python
                :nvim-neotest/neotest-plenary]
 :keys [{1 :<space>tn
         2 #((. (. (require :neotest) :run) :run))
         :desc "[t]est the [n]earest case"}
        {1 :<space>tf
         2 #((. (. (require :neotest) :run) :run) (_G.vim.fn.expand "%"))
         :desc "[t]est the current [f]ile"}
        {1 :<space>ts
         2 #((. (. (require :neotest) :run) :run) {:suite true})
         :desc "[t]est the [s]uite"}
        {1 :<leader>ut
         2 #((. (. (require :neotest) :summary) :toggle))
         :desc "[u]i to [t]oggle neotest [s]ummary"}]
 :config (fn []
           ((. (require :neotest) :setup) {:adapters [((require :neotest-python) {:dap {:justMyCode false}})
                                                      (require :neotest-plenary)]}))}
