(let [wk (require :which-key)]
  (wk.add [{1 :<leader>u :group "[u]i"}
           {1 :<leader>s :group "[s]earch"}
           {1 :<leader>t :group "[t]est"}
           {1 :<leader>n :group "[N]eorg"}
           {1 :<leader>un
            2 :<cmd>NoiceDismiss<cr>
            :desc "Dismiss All Notifications"}
           {1 :<leader>i :group "[I]ntentions"}
           {1 :<leader>ie
            2 #(_G.vim.cmd.edit {:args [(.. (_G.vim.fn.fnamemodify (_G.vim.fn.stdpath :data)
                                                                   ":h")
                                            :/clhd/active.actions)]})
            :desc "Edit clearhead actions file"}
           {1 :<leader><tab> :group "[tab]s"}
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
           {1 :<leader>q
            2 #(_G.vim.diagnostic.setloclist)
            :desc "Open diagnostic [Q]uickfix list"}
           {1 :<Esc><Esc>
            2 "<C-\\><C-n>"
            :mode :t
            :desc "[Esc]ape terminal mode"}
           ;; Lazy/Noice
           {1 :<leader>l 2 :<cmd>Lazy<CR> :desc "Start Lazy"}
           {1 :<leader>ecn
            2 "<cmd>cd $HOME/.local/share/chezmoi/.chezmoitemplates/nvim/ |edit ./init.fnl<CR>"
            :desc "[e]dit [c]hezmoi [n]eovim config by cding to chezmoi template dir and editing the fennel init to start"}
           {1 :<leader>ecf
            2 "<cmd>cd $HOME/.local/share/chezmoi |edit ./dot_config/fish/config.fish.tmpl<CR>"
            :desc "[e]dit [c]hezmoi [f]ish config by cd'ing to chezmoi dir and editing the fish init to start"}
           {1 :<leader>ecr
            2 "<cmd>cd -<CR>"
            :desc "[e]dit [c]hezmoi, [r]eturn to previous directory"}
           {1 :<leader>eca
            2 "<cmd>!chezmoi apply --force<CR>"
            :desc "[e]dit [c]hezmoi config by [a]pplying existing changes"}]))

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

