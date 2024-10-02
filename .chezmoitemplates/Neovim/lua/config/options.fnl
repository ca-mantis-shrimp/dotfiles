
(set _G.vim.g.mapleader " ")
(set _G.vim.g.maplocalleader " ")

(set _G.vim.g.have_nerd_font true)

(set _G.vim.opt.number true)
(set _G.vim.opt.relativenumber true)

(set _G.vim.opt.mouse "a")

(set _G.vim.opt.showmode false)

(set _G.vim.opt.breakindent true)

(set _G.vim.opt.undofile true)

(set _G.vim.opt.ignorecase true)
(set _G.vim.opt.smartcase true)

(set _G.vim.opt.signcolumn "yes")

(set _G.vim.opt.updatetime 250)

(set _G.vim.opt.timeoutlen 300)

(set _G.vim.opt.splitright true)
(set _G.vim.opt.splitbelow true)

(set _G.vim.opt.list true)
(set _G.vim.opt.listchars {:tab "» " :trail "·" :nbsp "␣"})

(set _G.vim.opt.inccommand "split")

(set _G.vim.opt.cursorline true)
(set _G.vim.opt.scrolloff 10)

(set _G.vim.opt.hlsearch true)

;; GUI options
(set _G.vim.o.guifont "FiraCode Nerd Font:h20")
(set _G.vim.g.neovide_scale_factor 1.0)

(when (= (_G.vim.fn.has "win32") 1)
  (set _G.vim.g.python_host_prog
       "~/AppData/Local/Microsoft/WindowsApps/PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0/python.exe"))

(set _G.vim.opt.formatexpr "require'conform'.formatexpr()")
