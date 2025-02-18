-- [nfnl] Compiled from lua/plugins/smartSplits.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	return require("smart-splits").resize_left()
end
local function _2_()
	return require("smart-splits").resize_down()
end
local function _3_()
	return require("smart-splits").resize_up()
end
local function _4_()
	return require("smart-splits").resize_right()
end
local function _5_()
	return require("smart-splits").move_cursor_left()
end
local function _6_()
	return require("smart-splits").move_cursor_down()
end
local function _7_()
	return require("smart-splits").move_cursor_up()
end
local function _8_()
	return require("smart-splits").move_cursor_right()
end
local function _9_()
	return require("smart-splits").swap_buf_left()
end
local function _10_()
	return require("smart-splits").swap_buf_up()
end
local function _11_()
	return require("smart-splits").swap_buf_down()
end
local function _12_()
	return require("smart-splits").swap_buf_right()
end
return {
	"mrjones2014/smart-splits.nvim",
	config = true,
	keys = {
		{ "<A-h>", _1_, desc = "Resize Split Left" },
		{ "<A-j>", _2_, desc = "Resize Split Down" },
		{ "<A-k>", _3_, desc = "Resize Split Up" },
		{ "<A-l>", _4_, desc = "Resize Split Right" },
		{ "<C-h>", _5_, desc = "Move Cursor Left" },
		{ "<C-j>", _6_, desc = "Move Cursor Down" },
		{ "<C-k>", _7_, desc = "Move Cursor Up" },
		{ "<C-l>", _8_, desc = "Move Cursor Right" },
		{ "<leader><leader>h", _9_, desc = "Swap Buffer Left" },
		{ "<leader><leader>j", _10_, desc = "Swap Buffer Up" },
		{ "<leader><leader>k", _11_, desc = "Swap Buffer Down" },
		{ "<leader><leader>l", _12_, desc = "Swap Buffer Right" },
	},
}
