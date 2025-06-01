-- [nfnl] lua/config/autocmds.fnl
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
_G.vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yanking text",
	group = _G.vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = _2_,
})
local function _3_(event)
	local map
	local function _4_(keys, func, desc)
		return _G.vim.keymap.set("n", keys, func, { buffer = event.buf, desc = ("LSP: " .. desc) })
	end
	map = _4_
	map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	map("<leader>rn", _G.vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>ca", _G.vim.lsp.buf.code_action, "[C]ode [A]ction")
	map("K", _G.vim.lsp.buf.hover, "Hover Documentation")
	map("gD", _G.vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	local client = _G.vim.lsp.get_client_by_id(event.data.client_id)
	if client and client.server_capabilities.documentHighlightProvider then
		_G.vim.api.nvim_create_autocmd(
			{ "CursorHold", "CursorHoldI" },
			{ buffer = event.buf, callback = _G.vim.lsp.buf.document_highlight }
		)
		_G.vim.api.nvim_create_autocmd(
			{ "CursorMoved", "CursorMovedI" },
			{ buffer = event.buf, callback = _G.vim.lsp.buf.clear_references }
		)
	else
	end
	if client and client.server_capabilities.inlayHintProvider and _G.vim.lsp.inlay_hint then
		local function _6_()
			return _G.vim.lsp.inlay_hint.enable(0, not _G.vim.lsp.inlay_hint.is_enabled())
		end
		return map("<leader>th", _6_, "[T]oggle Inlay [H]ints")
	else
		return nil
	end
end
_G.vim.api.nvim_create_autocmd(
	"LspAttach",
	{ group = _G.vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }), callback = _3_ }
)
local function _8_(args)
	local fnl_path = args.file
	local lua_path = string.gsub(fnl_path, "%.fnl$", ".lua")
	if _G.vim.loop.fs_stat(lua_path) then
		local buf = _G.vim.fn.bufadd(lua_path)
		_G.vim.fn.bufload(buf)
		local function _9_()
			return _G.vim.cmd("write")
		end
		_G.vim.api.nvim_buf_call(buf, _9_)
		return _G.vim.cmd(("bd! " .. buf))
	else
		return nil
	end
end
return _G.vim.api.nvim_create_autocmd("BufWritePost", {
	group = _G.vim.api.nvim_create_augroup("FnlToLuaChezmoi", { clear = true }),
	pattern = (os.getenv("HOME") .. "/.local/share/chezmoi/.chezmoitemplates/nvim/*.fnl"),
	callback = _8_,
})
