(let [wk (require :which-key)]
  (wk.add [{1 :<leader>c :group "[C]ode"}
           {1 :<leader>d :group "[D]ocument"}
           {1 :<leader>h :group "Git [H]unk"}
           {1 :<leader>r :group "[R]ename"}
           {1 :<leader>s :group "[S]earch"}
           {1 :<leader>t :group "[T]oggle"}
           {1 :<leader>w :group "[W]orkspace"}
           {1 :<leader>n :group "[N]eorg"}
           {1 :<leader>l :group "[L]ists in Neorg"}
           {1 :<leader>i :group "[I]ntentions"}
           {1 :<leader>ie
            2 #(_G.vim.cmd.edit {:args [(.. (_G.vim.fn.fnamemodify (_G.vim.fn.stdpath :data)
                                                                   ":h")
                                            :/clhd/main.actions)]})
            :desc "Edit clearhead actions file"}
           {1 :<leader>h :desc "Git [H]unk" :mode :v}
           {1 :<Esc>
            2 :<cmd>nohlsearch<CR>
            :desc "Remove Search Highlighting on Escape"}
           ;; Diagnositcs
           {1 "[d"
            2 #(_G.vim.diagnostic.goto_prev)
            :desc "Go to previous [D]iagnostic message"}
           {1 "]d"
            2 #(_G.vim.diagnostic.goto_next)
            :desc "Go to next [D]iagnostic message"}
           {1 :<leader>e
            2 #(_G.vim.diagnostic.open_float)
            :desc "Show diagnostic [E]rror messages"}
           {1 :<leader>q
            2 #(_G.vim.diagnostic.setloclist)
            :desc "Open diagnostic [Q]uickfix list"}
           {1 :<Esc><Esc>
            2 "<C-\\><C-n>"
            :mode :t
            :desc "[Esc]ape terminal mode"}
           ;; Tabs
           {1 :<leader><tab><tab> 2 :<cmd>tabnew<CR> :desc "Create New [tab]"}
           {1 :<leader><tab><Del>
            2 :<cmd>tabclose<CR>
            :desc "[Del]ete Current Tab"}
           {1 :<leader><tab>n 2 :<cmd>tabNext<CR> :desc "[n]ext Tab"}
           {1 :<leader><tab>p 2 :<cmd>tabprevious<CR> :desc "[p]revious Tab"}
           {1 :<leader><tab>r
            2 "<cmd>tcd -<CR>"
            :desc "CD to previous directory in current tab"}
           {1 :<leader><tab>b
            2 "<cmd>tcd %:p:h<CR>"
            :desc "CD to [B]uffer Directory"}
           ;; Lazy/Noice
           {1 :<leader>l 2 :<cmd>Lazy<CR> :desc "Start Lazy"}
           {1 :<leader>un
            2 :<cmd>NoiceDismiss<cr>
            :desc "Dismiss All Notifications"}
           ;; Norg Keymaps
           {1 :<leader>se
            2 "<cmd>Telescope neorg search_headings<CR>"
            :desc "Search Headings"}
           {1 :<leader>nr
            2 "<cmd>Neorg return<CR>"
            :desc "Return from Neorg Workspace"}
           {1 :<leader>nT
            2 "<cmd>Neorg tangle current-file<CR>"
            :desc "Tangle Current File"}
           {1 :<leader>ni
            2 "<cmd>Neorg index<CR>"
            :desc "Go to Index of Neorg Workspace"}
           ;; Tests
           {1 :<space>tn
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
            :desc "[u]i to [t]oggle neotest [s]ummary"}
           ;; Code Companion
           {1 :<leader>uc
            2 "<cmd>CodeCompanionChat Toggle<CR>"
            :desc "[u]i to toggle code completion [c]hat"}
           {1 :<leader>sA
            2 :<cmd>CodeCompanionActions<CR>
            :desc "[s]earch CodeCompanion [a]ctions"}]))

;; Window Focus
(_G.vim.keymap.set :n :<C-h> :<C-w><C-h>
                   {:desc "Move focus to the left window"})

(_G.vim.keymap.set :n :<C-l> :<C-w><C-l>
                   {:desc "Move focus to the right window"})

(_G.vim.keymap.set :n :<C-j> :<C-w><C-j>
                   {:desc "Move focus to the lower window"})

(_G.vim.keymap.set :n :<C-k> :<C-w><C-k>
                   {:desc "Move focus to the upper window"})

;; GUI
(fn change-scale-factor [delta]
  (set _G.vim.g.neovide_scale_factor (* _G.vim.g.neovide_scale_factor delta)))

;; Resize GUI
(_G.vim.keymap.set :n :<C-=> #(change-scale-factor 1.25))
(_G.vim.keymap.set :n :<C--> #(change-scale-factor (/ 1 1.25)))
;; Reset GUI Size
(_G.vim.keymap.set :n "<C-[>" #(set _G.vim.g.neovide_scale_factor 1.0))

;; Emulating Control+S on other applications
(_G.vim.keymap.set :n :<C-s> :<cmd>w<CR> {:desc "Save current Buffer"})

