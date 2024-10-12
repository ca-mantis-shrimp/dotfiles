{1 :nvim-neotest/neotest
 :dependencies [:nvim-neotest/nvim-nio
                :antoinemadec/FixCursorHold.nvim
                :nvim-neotest/neotest-python
                :nvim-neotest/neotest-plenary]
 :config (fn []
           ((. (require :neotest) :setup) {:adapters [((require :neotest-python) {:dap {:justMyCode false}})
                                                      (require :neotest-plenary)]}))}

