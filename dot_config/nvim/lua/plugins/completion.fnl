[{1 :hrsh7th/nvim-cmp
  :event :InsertEnter
  :dependencies [{1 :L3MON4D3/LuaSnip
                  :build (fn []
                           (if (or (_G.vim.fn.has :win32)
                                   (= (_G.vim.fn.executable :make) 0))
                               nil
                               "make install_jsregexp"))
                  :dependencies [{1 :rafamadriz/friendly-snippets
                                  :config #((. (require :luasnip.loaders.from_vscode)
                                               :lazy_load))}]}
                 {1 :zbirenbaum/copilot-cmp
                  :config true
                  :dependencies [{1 :zbirenbaum/copilot.lua :config true}]
                  :opts {:suggestion {:enabled false} :panel {:enabled false}}}
                 :saadparwaiz1/cmp_luasnip
                 :hrsh7th/cmp-nvim-lsp
                 :hrsh7th/cmp-path
                 :Paterjason/cmp-conjure
                 {1 :olimorris/codecompanion.nvim
                  :config #((. (require :codecompanion) :setup) {:strategies {:chat {:adapter :anthropic}
                                                                              :inline {:adapter :anthropic}}})}]
  :config (fn []
            (let [cmp (require :cmp)
                  luasnip (require :luasnip)]
              (luasnip.config.setup {})
              (cmp.setup {:snippet {:expand (fn [args]
                                              (luasnip.lsp_expand args.body))}
                          :completion {:completeopt ":menu,menuone,noinsert"}
                          :mapping (cmp.mapping.preset.insert {:<C-n> (cmp.mapping.select_next_item)
                                                               :<C-p> (cmp.mapping.select_prev_item)
                                                               :<C-b> (cmp.mapping.scroll_docs -4)
                                                               :<C-f> (cmp.mapping.scroll_docs 4)
                                                               :<C-y> (cmp.mapping.confirm {:select true})
                                                               :<C-Space> (cmp.mapping.complete {})
                                                               :<C-l> (cmp.mapping #((if (luasnip.expand_or_locally_jumpable -1)
                                                                                         (luasnip.jump -1)))
                                                                                   [:i
                                                                                    :s])})
                          :sources [{:name :copilot :group_index 2}
                                    {:name :nvim_lsp}
                                    {:name :luasnip}
                                    {:name :path}
                                    {:name :conjure}
                                    {:name :codecompanion}]})))}]

