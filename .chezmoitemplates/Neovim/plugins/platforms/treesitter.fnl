{1 :nvim-treesitter/nvim-treesitter
 :build ":TSUpdate"
 :dependencies [{1 :ClearHeadToDo-Devs/tree-sitter-actions :dev true}]
 :opts {:ensure_installed [:bash
                           :c
                           :html
                           :lua
                           :luadoc
                           :markdown
                           :vim
                           :vimdoc
                           :python]
        :auto_install true
        :highlight {:enable true}
        :indent {:enable true}
        :incremental_selection {:enable true
                                :keymaps {:init_selection :gsi
                                          :node_incremental :gsn
                                          :scope_incremental :gss
                                          :node_decremental :gsd}}}
 :config (fn [_ opts]
           (tset (require :nvim-treesitter.install) :prefer_git true)
           (if (= (_G.vim.fn.has :win32) 1)
               (tset (require :nvim-treesitter.install) :compilers [:zig]))
           ((. (require :nvim-treesitter.configs) :setup) opts)
           (tset _G.vim.opt :foldmethod :expr)
           (tset _G.vim.opt :foldexpr "nvim_treesitter#foldexpr()")
           (let [parser_config ((. (require :nvim-treesitter.parsers)
                                   :get_parser_configs))
                 dev-path "~/Products/tree-sitter-actions"
                 lazy-path (.. (_G.vim.fn.stdpath :data)
                               :/lazy/tree-sitter-actions)
                 ;; Check which path exists (expand for check only)
                 parser-url (if (= (_G.vim.fn.isdirectory (_G.vim.fn.expand dev-path))
                                   1)
                                dev-path
                                lazy-path)]
             (set parser_config.actions
                  {:install_info {:url parser-url :files {1 :src/parser.c}}})))}

