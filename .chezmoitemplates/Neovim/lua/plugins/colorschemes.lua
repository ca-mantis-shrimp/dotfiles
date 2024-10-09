-- [nfnl] Compiled from lua/plugins/colorschemes.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	return _G.vim.cmd.colorscheme("tokyonight-night")
end
return { { "projekt0n/github-nvim-theme" }, { "folke/tokyonight.nvim", priority = 1000, init = _1_ } }
