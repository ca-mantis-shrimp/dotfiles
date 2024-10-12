-- [nfnl] Compiled from lua/plugins/mini.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	require("mini.ai").setup({ n_lines = 500 })
	require("mini.surround").setup()
	do
		local statusline = require("mini.statusline")
		local function _2_()
			return "%2l:%-2v"
		end
		statusline["section_location"] = _2_
	end
	require("mini.files").setup()
	local function _3_()
		return MiniFiles.open()
	end
	return _G.vim.keymap.set("n", "<leader>F", _3_, { desc = "Open File Explorer" })
end
return { "echasnovsk/mini.nvim", version = "*", config = _1_ }
