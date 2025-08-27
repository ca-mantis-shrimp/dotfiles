-- [nfnl] neovim/plugins/colorschemes.fnl
local function _1_()
	return _G.vim.cmd.colorscheme("tokyonight-night")
end
return { { "projekt0n/github-nvim-theme" }, { "folke/tokyonight.nvim", priority = 1000, init = _1_ } }
