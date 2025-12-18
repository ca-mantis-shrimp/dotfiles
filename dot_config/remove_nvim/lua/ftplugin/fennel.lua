-- [nfnl] dot_config/remove_nvim/lua/ftplugin/fennel.fnl
return _G.vim.keymap.set("n", "<localLeader>ol", "<cmd>e %:p.lua<cr>", {buffer = true, desc = "Open corresponding .lua file"})
