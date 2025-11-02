(set _G.vim.opt.exrc true)

(set _G.vim.opt.autochdir true)

(set _G.vim.opt.mouse :a)

(set _G.vim.opt.showmode false)

(set _G.vim.opt.undofile true)

(set _G.vim.opt.updatetime 250)

(_G.vim.filetype.add {:extension {:http :http}})

(set _G.vim.g.mapleader " ")
(set _G.vim.g.maplocalleader ",")

(set _G.vim.opt.ignorecase true)
(set _G.vim.opt.smartcase true)

(set _G.vim.opt.inccommand :split)

(set _G.vim.opt.hlsearch true)

(set _G.vim.opt.timeoutlen 300)

(set _G.vim.g.neovide_scale_factor 1.0)

(set _G.vim.opt.formatexpr "require'conform'.formatexpr()")

(_G.vim.lsp.enable [:lua_ls
:fennel_language_server
:pyright
:fish-lsp
:systemd_ls
:powershell_es
:jsonls
:clojure_lsp
:rust_analyzer])

(_G.vim.diagnostic.config {:virtual_text {:current_line true}
:virtual_lines true})

(set _G.vim.o.winborder :rounded)

(set _G.vim.opt.splitright true)
(set _G.vim.opt.splitbelow true)

(set _G.vim.opt.list true)
(set _G.vim.opt.listchars {:tab "» " :trail "·" :nbsp "␣"})

(set _G.vim.opt.signcolumn :yes)

(set _G.vim.opt.cursorline true)
(set _G.vim.opt.scrolloff 10)

(set _G.vim.opt.breakindent true)

(set _G.vim.opt.number true)
(set _G.vim.opt.relativenumber true)

;; Default LSP to .git/ as root marker
(_G.vim.lsp.config "*" {:root_marker [:.git/]})

(_G.vim.api.nvim_create_autocmd :LspAttach
                                {:callback (fn [ev]
                                             (local client
                                                    (_G.vim.lsp.get_client_by_id ev.data.client))
                                             (if (and client
                                                      (client:supports_method :textDocument/completion))
                                                 (_G.vim.lsp.completion.enable true
                                                                               client.id
                                                                               ev.buf
                                                                               {:autoigger true})))})

;; Defaulting to Rounded borders
(set _G.vim.o.winborder :rounded)

;; Defaulting to only showing the current line of diagnostics
(_G.vim.diagnostic.config {:virtual_text {:current_line true}
                           :virtual_lines true})

