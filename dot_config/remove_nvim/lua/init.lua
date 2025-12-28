-- [nfnl] dot_config/remove_nvim/lua/init.fnl
require("config.options")
require("config.utils")
require("config.literate_inspector")
local lazypath = (_G.vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not _G.vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	_G.vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
else
end
_G.vim.opt.rtp:prepend(lazypath)
do
	local lazy = require("lazy")
	local setup_opts =
		{ spec = { { import = "plugins" } }, dev = { path = "~/Products", patterns = { "tree-sitter-actions" } } }
	lazy.setup(setup_opts)
end
require("config.keymaps")
require("config.autocmds")
return require("config.literate_workflow")
