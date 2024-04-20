vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.hlsearch = true

vim.keymap.set('n', '<leader><tab>c', '<cmd>tcd ~/.local/share/chezmoi<CR>', {})
vim.keymap.set('n', '<leader><tab>r', '<cmd>tcd -<CR>', {})

vim.o.guifont = "FiraCode NF:h20"

vim.g.neovide_scale_factor = 1.0

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1/1.25)
end)
vim.keymap.set("n", "<C-[>", function()
  vim.g.neovide_scale_factor = 1.0
end)

if vim.fn.has("windows") then
  vim.g.python_host_prog = vim.fn.expand('$HOME/python_virtual_environments/dev3.12.0/Scripts/python')
  vim.g.python3_host_prog = vim.fn.expand('$HOME/python_virtual_environments/dev3.12.0/Scripts/python')
else
  vim.g.python_host_prog = vim.fn.expand('$HOME/.pyenv/versions/3.12.0/envs/dev3.12.0/bin/python')
  vim.g.python3_host_prog = vim.fn.expand('$HOME/.pyenv/versions/3.12.0/envs/dev3.12.0/bin/python')
end