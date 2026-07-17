require("config.utils").setup_treesitter.full()

vim.wo.conceallevel = 2
vim.wo.spell = true

-- Enforce MD013: hard-wrap prose at 80 columns as you type
vim.bo.textwidth = 80
vim.opt_local.colorcolumn = "80"
vim.opt_local.formatoptions:append("t") -- auto-wrap text at textwidth
vim.opt_local.formatoptions:remove("l") -- don't skip lines already over textwidth
