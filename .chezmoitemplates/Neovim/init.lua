-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
require("config.options")
local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
else
end
vim.opt.rtp:prepend(lazypath)
do
	local lazy = require("lazy")
	local setup_opts =
		{ dev = { path = "~/Products" }, rocks = { hererocks = true }, spec = { { import = "plugins" } } }
	lazy.setup(setup_opts)
end
require("config.keymaps")
require("config.autocmds")
return require("config.tree-sitter_config")
