-- [nfnl] dot_config/remove_nvim/init.fnl
local function lazy_bootstrap()
  local lazypath = (_G.vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  if not _G.vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    _G.vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
  else
  end
  return _G.vim.opt.rtp:prepend(lazypath)
end
require("config.options")
require("config.utils")
lazy_bootstrap()
do
  local lazy = require("lazy")
  local setup_opts = {spec = {{import = "plugins"}, {import = "plugins.platforms"}}, dev = {path = "~/Products"}}
  lazy.setup(setup_opts)
end
require("config.keymaps")
return require("config.autocmds")
