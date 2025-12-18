-- [nfnl] dot_config/remove_nvim/lua/config/literate_workflow.fnl
local M = {}
M["verify-norg-buffer"] = function(bufnr)
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	if bufname:match("%.norg$") then
		return bufname
	else
		return nil, "Not a .norg file!"
	end
end
M["save-if-modified"] = function(bufnr)
	if vim.bo[bufnr].modified then
		vim.notify("Saving buffer before tangling...", vim.log.levels.INFO)
		local function _2_()
			return vim.cmd.write()
		end
		vim.api.nvim_buf_call(bufnr, _2_)
	else
	end
	return true
end
M["get-tangle-metadata"] = function(bufnr)
	local ok, neorg = pcall(require, "neorg")
	if not ok then
		return nil, "Neorg not available"
	else
		local ts = neorg.modules.get_module("core.integrations.treesitter")
		if ts then
			local metadata = ts.get_document_metadata(bufnr)
			if metadata and metadata.tangle then
				return metadata.tangle
			else
				return nil, "No tangle directive in document metadata"
			end
		else
			return nil, "Neorg treesitter module not loaded"
		end
	end
end
M["tangle-current-file"] = function()
	local ok, err = pcall(vim.cmd, "Neorg tangle current-file")
	if ok then
		vim.wait(100)
		return true
	else
		return nil, ("Tangle command failed: " .. tostring(err))
	end
end
M["compile-fennel"] = function(filepath)
	local ok, nfnl = pcall(require, "nfnl.api")
	if not ok then
		vim.notify("nfnl not available, skipping compilation", vim.log.levels.WARN)
		return true
	else
		local compile_file = nfnl["compile-file"]
		local dir = vim.fn.fnamemodify(filepath, ":h")
		local result = compile_file({ path = filepath, dir = dir })
		if result.status == "ok" then
			return true
		else
			return nil, (result.error or ("nfnl compilation failed for " .. filepath))
		end
	end
end
M["process-fennel-file"] = function(filepath)
	local ok, err = M["compile-fennel"](filepath)
	if not ok then
		return nil, err
	else
		local lua_file = filepath:gsub("%.fnl$", ".lua")
		return M["format-lua"](lua_file)
	end
end
M["apply-with-chezmoi"] = function()
	local output = vim.fn.system("chezmoi apply 2>&1")
	local exit_code = vim.v.shell_error
	if exit_code == 0 then
		return true
	else
		local qf_entries = {}
		for line in output:gmatch("[^\r\n]+") do
			table.insert(qf_entries, { text = line })
		end
		vim.fn.setqflist(qf_entries, "r")
		vim.fn.setqflist({}, "a", { title = "chezmoi apply errors" })
		vim.cmd.copen()
		return nil, "chezmoi apply failed! Check quickfix list."
	end
end
M["tangle-and-apply"] = function()
	local bufnr = vim.api.nvim_get_current_buf()
	do
		local bufname, err = M["verify-norg-buffer"](bufnr)
		if not bufname then
			vim.notify(err, vim.log.levels.ERROR)
			return
		else
		end
	end
	M["save-if-modified"](bufnr)
	local tangle_path, err = M["get-tangle-metadata"](bufnr)
	if not tangle_path then
		vim.notify(err, vim.log.levels.ERROR)
		return
	else
	end
	local ok, err0 = M["tangle-current-file"]()
	if not ok then
		vim.notify(err0, vim.log.levels.ERROR)
		return
	else
	end
	if (type(tangle_path) == "string") and tangle_path:match("%.fnl$") then
		local bufdir = vim.fn.fnamemodify(bufname, ":h")
		local abs_path = vim.fn.fnamemodify((bufdir .. "/" .. tangle_path), ":p")
		local ok0, err1 = M["process-fennel-file"](abs_path)
		if not ok0 then
			vim.notify(err1, vim.log.levels.ERROR)
			return
		else
		end
	else
	end
	vim.api.nvim_set_current_buf(bufnr)
	local ok0, err1 = M["apply-with-chezmoi"]()
	if ok0 then
		return vim.notify("Successfully tangled and applied!", vim.log.levels.INFO)
	else
		return vim.notify(err1, vim.log.levels.ERROR)
	end
end
vim.api.nvim_create_user_command("TangleAndApply", M["tangle-and-apply"], {})
local function _18_()
	return vim.keymap.set(
		"n",
		"<leader>nA",
		M["tangle-and-apply"],
		{ buffer = true, desc = "Tangle and apply literate config" }
	)
end
vim.api.nvim_create_autocmd("FileType", { pattern = "norg", callback = _18_ })
return M
