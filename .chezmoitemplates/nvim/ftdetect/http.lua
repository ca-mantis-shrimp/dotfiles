-- [nfnl] Compiled from ftdetect/http.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	_G.vim.bo.filetype = "http"
	return nil
end
return _G.vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.http", callback = _1_ })
