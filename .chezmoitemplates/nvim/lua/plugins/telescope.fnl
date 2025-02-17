{1 :nvim-telescope/telescope.nvim
 :event :VimEnter
 :branch :0.1.x
 :dependencies [{1 :nvim-telescope/telescope-fzf-native.nvim
                 :build :make
                 :cond (fn []
                         (= (_G.vim.fn.executable :make) 1))}
                :nvim-telescope/telescope-ui-select.nvim
                {1 :nvim-tree/nvim-web-devicons
                 :enabled _G.vim.g.have_nerd_font}
                {1 :ahmedkhalf/project.nvim
                 :config (fn []
                           ((. (require :project_nvim) :setup) {}))}
                {1 :xvzc/chezmoi.nvim :config true}]
 :config (fn []
           (let [telescope (require :telescope)
                 themes (require :telescope.themes)
                 builtin (require :telescope.builtin)]
             ((. telescope :setup) {:defaults {:mappings {:i {:<c-enter> :to_fuzzy_refine}}
                                               :extensions {:ui-select [((. themes
                                                                            :get_dropdown))]}}})
             ((. telescope :load_extension) :fzf)
             ((. telescope :load_extension) :ui-select)
             ((. telescope :load_extension) :projects)
             ((. telescope :load_extension) :chezmoi)
             (_G.vim.keymap.set :n :<leader>sh builtin.help_tags
                                {:desc "[S]earch [H]elp"})
             (_G.vim.keymap.set :n :<leader>sk builtin.keymaps
                                {:desc "[S]earch [K]eymaps"})
             (_G.vim.keymap.set :n :<leader>sf builtin.find_files
                                {:desc "[S]earch [F]iles"})
             (_G.vim.keymap.set :n :<leader>ss builtin.builtin
                                {:desc "[S]earch [S]elect [T]elescope"})
             (_G.vim.keymap.set :n :<leader>sw builtin.grep_string
                                {:desc "[S]earch current [W]ord"})
             (_G.vim.keymap.set :n :<leader>sg builtin.live_grep
                                {:desc "[S]earch by [G]rep"})
             (_G.vim.keymap.set :n :<leader>sd builtin.diagnostics
                                {:desc "[S]earch [D]iagnostics"})
             (_G.vim.keymap.set :n :<leader>sr builtin.resume
                                {:desc "[S]earch [R]esume"})
             (_G.vim.keymap.set :n :<leader>sp
                                #(telescope.extensions.projects.projects {})
                                {:desc "[S]earch Recent [p]rojects"})
             (_G.vim.keymap.set :n :<leader>s. builtin.oldfiles
                                {:desc "[S]earch Recent Files for repeat"})
             (_G.vim.keymap.set :n :<leader><leader> builtin.buffers
                                {:desc "Search buffers"})))}

