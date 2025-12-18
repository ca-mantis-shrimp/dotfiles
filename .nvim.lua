-- [nfnl] .nvim.fnl
_G.vim.opt.makeprg = "chezmoi apply"
return _G.vim.keymap.set("n", "<leader>cm", "<cmd>make<cr>", {desc = "Run chezmoi apply to sync changes"})
