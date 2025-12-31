_G.vim.opt.exrc = true
_G.vim.opt.autochdir = true
_G.vim.opt.mouse = "a"
_G.vim.opt.showmode = false
_G.vim.opt.undofile = true
_G.vim.opt.updatetime = 250
_G.vim.filetype.add({ extension = { http = "http" } })
_G.vim.g.mapleader = " "
_G.vim.g.maplocalleader = ","
_G.vim.opt.ignorecase = true
_G.vim.opt.smartcase = true
_G.vim.opt.inccommand = "split"
_G.vim.opt.hlsearch = true
_G.vim.opt.timeoutlen = 300
_G.vim.opt.formatexpr = "require'conform'.formatexpr()"
_G.vim.lsp.enable({
	"lua_ls",
	"fennel_language_server",
	"pyright",
	"fish-lsp",
	"systemd_lsp",
	"powershell_es",
	"jsonls",
	"clojure_lsp",
	"rust_analyzer",
})
_G.vim.diagnostic.config({ virtual_text = { current_line = true }, virtual_lines = true })
_G.vim.o.winborder = "rounded"
_G.vim.opt.splitright = true
_G.vim.opt.splitbelow = true
_G.vim.opt.list = true
_G.vim.opt.listchars = { tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163" }
_G.vim.opt.signcolumn = "yes"
_G.vim.opt.cursorline = true
_G.vim.opt.scrolloff = 10
_G.vim.opt.breakindent = true
_G.vim.opt.number = true
_G.vim.opt.relativenumber = true
_G.vim.g.have_nerd_font = true
_G.vim.g.neovide_scale_factor = 1.0
return nil
