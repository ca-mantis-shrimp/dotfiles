-- [nfnl] Compiled from lua/config/options.fnl by https://github.com/Olical/nfnl, do not edit.
_G.vim.g.mapleader = " "
_G.vim.g.maplocalleader = " "
_G.vim.g.have_nerd_font = true
_G.vim.opt.number = true
_G.vim.opt.relativenumber = true
_G.vim.opt.mouse = "a"
_G.vim.opt.showmode = false
_G.vim.opt.breakindent = true
_G.vim.opt.undofile = true
_G.vim.opt.ignorecase = true
_G.vim.opt.smartcase = true
_G.vim.opt.signcolumn = "yes"
_G.vim.opt.updatetime = 250
_G.vim.opt.timeoutlen = 300
_G.vim.opt.splitright = true
_G.vim.opt.splitbelow = true
_G.vim.opt.list = true
_G.vim.opt.listchars = { tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163" }
_G.vim.opt.inccommand = "split"
_G.vim.opt.cursorline = true
_G.vim.opt.scrolloff = 10
_G.vim.opt.hlsearch = true
_G.vim.o.guifont = "FiraCode Nerd Font:h20"
_G.vim.g.neovide_scale_factor = 1
if _G.vim.fn.has("win32") == 1 then
	_G.vim.g.python_host_prog =
		"~/AppData/Local/Microsoft/WindowsApps/PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0/python.exe"
else
end
_G.vim.opt.formatexpr = "require'conform'.formatexpr()"
return nil
