vim.api.nvim_create_autocmd("FileType", {
  pattern = { "norg" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt.spelllang = { "en_us" }
  end,
})