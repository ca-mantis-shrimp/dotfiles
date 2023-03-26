-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--- wrap and check for spell in text filetypes
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "norg" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt.spelllang = { "en_us" }
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = { "https://deloitteus.service-now.com/" },
  callback = function()
    vim.bo.filetype = "javascript"
  end,
})
