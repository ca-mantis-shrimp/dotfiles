{1 :echasnovski/mini.nvim
 :version "*"
 :config (fn []
           ((. (require :mini.ai) :setup) {:n_lines 500})
           ((. (require :mini.surround) :setup))
           ((. (require :mini.statusline) :setup))
           ((. (require :mini.files) :setup))
           ((. (require :mini.pick) :setup))
           ((. (require :mini.sessions) :setup))
           ((. (require :mini.tabline) :setup)))
 :keys [[:n
         :<leader>F
         (fn []
           ((. _G.MiniFiles :open)))
         {:desc "Open File Explorer"}]]}

