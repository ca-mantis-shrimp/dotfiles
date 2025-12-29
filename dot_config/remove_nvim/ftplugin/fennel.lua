-- [nfnl] dot_config/remove_nvim/ftplugin/fennel.fnl
_G.vim.keymap.set(
	"n",
	"<localLeader>ol",
	"<cmd>e %:p.lua<cr>",
	{ buffer = true, desc = "Open corresponding .lua file" }
)
return require("config.utils").setup_treesitter_full()
