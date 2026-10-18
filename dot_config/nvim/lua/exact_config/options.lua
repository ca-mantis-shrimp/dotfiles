vim.opt.exrc = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.filetype.add({ extension = { http = "http" } })
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.hlsearch = true
vim.opt.timeoutlen = 300
vim.opt.cmdheight = 0 -- hide the command line unless needed
vim.opt.formatexpr = "require'conform'.formatexpr()"
-- Servers live outside nvim: on Linux, chezmoi's install-editor-tools script and externals.
vim.lsp.enable({
  "lua_ls",
  "pyright",
  "bashls",
  "fish-lsp",
  "systemd_lsp",
  "jsonls",
  "clojure_lsp",
  "rust_analyzer",
  "tsc",
  "oxlint",
  "copilot",
})
if vim.fn.has("win32") == 1 then vim.lsp.enable("powershell_es") end
vim.diagnostic.config({ virtual_text = { current_line = true }, virtual_lines = true })
vim.o.winborder = "rounded"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163" }
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.breakindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.have_nerd_font = true
vim.g.neovide_scale_factor = 1.0
