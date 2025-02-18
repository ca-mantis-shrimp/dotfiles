-- [nfnl] Compiled from lua/plugins/db.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return _G.vim.cmd(string.format("helptags %s", (_G.vim.fn.stdpath("data") .. "/lazy/dadbod/doc")))
end
return {{"tpope/vim-dadbod", build = _1_}}
