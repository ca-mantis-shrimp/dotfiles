-- [nfnl] dot_config/remove_nvim/ftplugin/norg.fnl
require("config.utils").setup_treesitter_full()
_G.vim.opt_local.wrap = true
_G.vim.opt_local.spell = true
_G.vim.opt_local.spelllang = { "en_us" }
_G.vim.opt_local.conceallevel = 2
local function _1_()
	return require("conform").format({ formatters = { "injected" } })
end
return _G.vim.keymap.set("n", "<localLeader>gf", _1_, { buffer = true, desc = "Format norg code blocks" })
