{1 :echasnovski/mini.nvim
 :version "*"
 :config (fn []
           ((. (require :mini.ai) :setup) {:n_lines 500})
           ((. (require :mini.surround) :setup))
           ((. (require :mini.statusline) :setup))
           ((. (require :mini.files) :setup))
           ((. (require :mini.pick) :setup))
           (_G.vim.keymap.set :n :<leader>F
                              (fn []
                                ((. MiniFiles :open)))
                              {:desc "Open File Explorer"}))}

