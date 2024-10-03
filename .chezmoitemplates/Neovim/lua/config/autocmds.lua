-- [nfnl] Compiled from lua/config/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	_G.vim.opt_local.wrap = true
	_G.vim.opt_local.spell = true
	_G.vim.opt.spelllang = { "en_us" }
	return nil
end
_G.vim.api.nvim_create_autocmd("FileType", { pattern = { "norg" }, callback = _1_ })
local function _2_()
	return _G.vim.highlight.on_yank()
end
return _G.vim.api.nvim_create_autocmd(
	"TextYankPost",
	{
		desc = "highlight when yanking text",
		group = _G.vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
		callback = _2_,
	}
)
