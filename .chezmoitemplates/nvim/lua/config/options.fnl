;; Loads arbitrary code so it comes first
(set _G.vim.opt.exrc true)

;; Setting Leader to Space and Local Leader to `,`
(set _G.vim.g.mapleader " ")
(set _G.vim.g.maplocalleader ",")

;; Makes sure we enable nerd font stuff
(set _G.vim.g.have_nerd_font true)

;; I like it when we have the raw number surrounded by relative numbers
(set _G.vim.opt.number true)
(set _G.vim.opt.relativenumber true)
(set _G.vim.opt.autochdir true)

(set _G.vim.opt.mouse :a)

(set _G.vim.opt.showmode false)

(set _G.vim.opt.breakindent true)

(set _G.vim.opt.undofile true)

(set _G.vim.opt.ignorecase true)
(set _G.vim.opt.smartcase true)

(set _G.vim.opt.signcolumn :yes)

(set _G.vim.opt.updatetime 250)

(set _G.vim.opt.timeoutlen 300)

(set _G.vim.opt.splitright true)
(set _G.vim.opt.splitbelow true)

(set _G.vim.opt.list true)
(set _G.vim.opt.listchars {:tab "» " :trail "·" :nbsp "␣"})

(set _G.vim.opt.inccommand :split)

(set _G.vim.opt.cursorline true)
(set _G.vim.opt.scrolloff 10)

(set _G.vim.opt.hlsearch true)

;; GUI options
(set _G.vim.g.neovide_scale_factor 1.0)

(set _G.vim.opt.formatexpr "require'conform'.formatexpr()")

;; Enable LSP Servers, Assumes server is either configured in `lsp/` or `lspconfig`
(_G.vim.lsp.enable [:lua_ls
                    :fennel_language_server
                    :pyright
                    :fish-lsp
                    :systemd_ls
                    :powershell_es
                    :jsonls
                    :clojure_lsp
                    :rust_analyzer])

;; Defaulting to Rounded borders
(set _G.vim.o.winborder :rounded)

;; Defaulting to only showing the current line of diagnostics
(_G.vim.diagnostic.config {:virtual_text {:current_line true}
                           :virtual_lines true})

