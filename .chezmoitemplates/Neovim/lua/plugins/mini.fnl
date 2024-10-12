{1 :echasnovsk/mini.nvim
 :version "*"
 :config (fn []
           ((. (require :mini.ai) :setup) {:n_lines 500})
           ((. (require :mini.surround) :setup))
           (let [statusline (require :mini.statusline)]
             (tset statusline :section_location (fn [] "%2l:%-2v")))
           ((. (require :mini.files) :setup))
           (_G.vim.keymap.set :n :<leader>F
                              (fn []
                                ((. MiniFiles :open)))
                              {:desc "Open File Explorer"}))}

