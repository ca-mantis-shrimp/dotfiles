-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
require("config.options")
local lazypath = (_G.vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
if not _G.vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	_G.vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
else
end
_G.vim.opt.rtp:prepend(lazypath)
do
	local lazy = require("lazy")
	local setup_opts = { dev = { path = "~/Products" }, spec = { { import = "plugins" } } }
	lazy.setup(setup_opts)
end
require("config.keymaps")
require("config.autocmds")
return require("config.tree-sitter_config")
