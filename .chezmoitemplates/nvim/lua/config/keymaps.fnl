;; Defining Whichkey Groups
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
           {1 :<leader>h :desc "Git [H]unk" :mode :v}]))

;; Quickly Remove Search Highlighting
(_G.vim.keymap.set :n :<Esc> :<cmd>nohlsearch<CR>)

;; Diagnostics
(_G.vim.keymap.set :n "[d" _G.vim.diagnostic.goto_prev
                   {:desc "Go to previous [D]iagnostic message"})

(_G.vim.keymap.set :n "]d" _G.vim.diagnostic.goto_next
                   {:desc "Go to next [D]iagnostic message"})

(_G.vim.keymap.set :n :<leader>e _G.vim.diagnostic.open_float
                   {:desc "Show diagnostic [E]rror messages"})

(_G.vim.keymap.set :n :<leader>q _G.vim.diagnostic.setloclist
                   {:desc "Open diagnostic [Q]uickfix list"})

;; Terminal Escape Remap
(_G.vim.keymap.set :t :<Esc><Esc> "<C-\\><C-n>"
                   {:desc "[Esc]ape terminal mode"})

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

;; Tabs
(_G.vim.keymap.set :n :<leader><tab><tab> :<cmd>tabnew<CR>
                   {:desc "Create New [tab]"})

(_G.vim.keymap.set :n :<leader><tab><Del> :<cmd>tabclose<CR>
                   {:desc "[Del]ete Current Tab"})

(_G.vim.keymap.set :n :<leader><tab>n :<cmd>tabNext<CR> {:desc "[n]ext Tab"})
(_G.vim.keymap.set :n :<leader><tab>p :<cmd>tabprevious<CR>
                   {:desc "[p]revious Tab"})

;; Chezmoi
(_G.vim.keymap.set :n :<leader><tab>c "<cmd>tcd ~/.local/share/chezmoi<CR>"
                   {:desc "CD to chezmoi in current tab"})

(_G.vim.keymap.set :n :<leader><tab>r "<cmd>tcd -<CR>"
                   {:desc "CD to previous directory in current tab"})

(_G.vim.keymap.set :n :<leader><tab>b "<cmd>tcd %:p:h<CR>"
                   {:desc "CD to [B]uffer Directory"})

(_G.vim.keymap.set :n :<leader><tab>a #(os.execute "chezmoi apply")
                   {:desc "Apply to Chezmoi"})

;; Emulating Control+S on other applications
(_G.vim.keymap.set :n :<C-s> :<cmd>w<CR> {:desc "Save current Buffer"})

;; Lazy/Noice
(_G.vim.keymap.set :n :<leader>l :<cmd>Lazy<CR> {:desc "Start Lazy"})
(_G.vim.keymap.set :n :<leader>un :<cmd>NoiceDismiss<cr>
                   {:desc "Dismiss All Notifications"})

;; Harpoon
(local harpoon (require :harpoon))

(_G.vim.keymap.set :n :<leader>a #(: (harpoon:list) :add)
                   {:desc "Add current file to harpoon list"})

(_G.vim.keymap.set :n :<leader>H #(harpoon.ui:toggle_quick_menu (harpoon:list))
                   {:desc "Toggle Harpoon Quick Menu"})

(_G.vim.keymap.set :n :<C-1> #(: (harpoon:list) :select 1)
                   {:desc "Select Harpoon item 1"})

(_G.vim.keymap.set :n :<C-2> #(: (harpoon:list) :select 2)
                   {:desc "Select Harpoon item 2"})

(_G.vim.keymap.set :n :<C-3> #(: (harpoon:list) :select 3)
                   {:desc "Select Harpoon item 3"})

(_G.vim.keymap.set :n :<C-4> #(: (harpoon:list) :select 4)
                   {:desc "Select Harpoon item 4"})

(_G.vim.keymap.set :n :<C-5> #(: (harpoon:list) :select 5)
                   {:desc "Select Harpoon item 5"})

(_G.vim.keymap.set :n :<C-6> #(: (harpoon:list) :select 6)
                   {:desc "Select Harpoon item 6"})

;; Norg Keymaps
(_G.vim.keymap.set :n :<leader>se "<cmd>Telescope neorg search_headings<CR>")
(_G.vim.keymap.set :n :<leader>nr "<cmd>Neorg return<CR>")
(_G.vim.keymap.set :n :<leader>nT "<cmd>Neorg tangle current-file<CR>")
(_G.vim.keymap.set :n :<leader>ni "<cmd>Neorg index<CR>")

;; Google Search
(_G.vim.keymap.set :n :<leader>sb
                   (fn []
                     (let [query (_G.vim.fn.input "Search Google: ")]
                       (when (not= query "")
                         (_G.vim.cmd {:cmd :OpenBrowserSmartSearch
                                      :args [(.. "'" query "'")]}))))
                   {:desc "search browser with google"})

;; Tests
(_G.vim.keymap.set :n :<space>tn #((. (. (require :neotest) :run) :run))
                   {:desc "[t]est the [n]earest case"})

(_G.vim.keymap.set :n :<space>tf
                   #((. (. (require :neotest) :run) :run) (_G.vim.fn.expand "%"))
                   {:desc "[t]est the current [f]ile"})

(_G.vim.keymap.set :n :<space>ts
                   #((. (. (require :neotest) :run) :run) {:suite true})
                   {:desc "[t]est the [s]uite"})

(_G.vim.keymap.set :n :<leader>ut
                   #((. (. (require :neotest) :summary) :toggle))
                   {:desc "[u]i to [t]oggle neotest [s]ummary"})

(_G.vim.keymap.set :n :<leader>uc "<cmd>CodeCompanionChat Toggle<CR>"
                   {:desc "[u]i to toggle code completion [c]hat"})

(_G.vim.keymap.set :n :<leader>sA :<cmd>CodeCompanionActions<CR>
                   {:desc "[s]earch CodeCompanion [a]ctions"})

