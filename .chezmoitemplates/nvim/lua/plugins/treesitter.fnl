{1 :nvim-treesitter/nvim-treesitter
 :build ":TSUpdate"
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
           (tset _G.vim.opt :foldexpr "nvim_treesitter#foldexpr()"))}

