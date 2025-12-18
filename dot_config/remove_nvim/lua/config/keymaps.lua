-- [nfnl] dot_config/remove_nvim/lua/config/keymaps.fnl
do
	local wk = require("which-key")
	local function _1_()
		return _G.vim.cmd.edit({
			args = { (_G.vim.fn.fnamemodify(_G.vim.fn.stdpath("data"), ":h") .. "/clhd/active.actions") },
		})
	end
	local function _2_()
		return _G.vim.diagnostic.goto_prev()
	end
	local function _3_()
		return _G.vim.diagnostic.goto_next()
	end
	local function _4_()
		return _G.vim.diagnostic.setloclist()
	end
	wk.add({
		{ "<leader>u", group = "[u]i" },
		{ "<leader>s", group = "[s]earch" },
		{ "<leader>t", group = "[t]est" },
		{ "<leader>n", group = "[N]eorg" },
		{ "<leader><tab>", group = "[tab]s" },
		{ "<leader>i", group = "[I]ntentions" },
		{ "<leader>ie", _1_, desc = "Edit clearhead actions file" },
		{ "<leader><tab><tab>", "<cmd>tabnew<CR>", desc = "Create New [tab]" },
		{ "<leader><tab><Del>", "<cmd>tabclose<CR>", desc = "[Del]ete Current Tab" },
		{ "<leader><tab>n", "<cmd>tabNext<CR>", desc = "[n]ext Tab" },
		{ "<leader><tab>p", "<cmd>tabprevious<CR>", desc = "[p]revious Tab" },
		{ "<leader><tab>r", "<cmd>tcd -<CR>", desc = "CD to previous directory in current tab" },
		{ "<leader>h", desc = "Git [H]unk", mode = "v" },
		{ "<Esc>", "<cmd>nohlsearch<CR>", desc = "Remove Search Highlighting on Escape" },
		{ "<Esc><Esc>", "<C-\\><C-n>", mode = "t", desc = "[Esc]ape terminal mode" },
		{ "[d", _2_, desc = "Go to previous [D]iagnostic message" },
		{ "]d", _3_, desc = "Go to next [D]iagnostic message" },
		{ "<leader>q", _4_, desc = "Open diagnostic [Q]uickfix list" },
		{ "<leader>un", "<cmd>NoiceDismiss<cr>", desc = "Dismiss All Notifications" },
		{ "<leader>l", "<cmd>Lazy<CR>", desc = "Start Lazy" },
	})
end
_G.vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
_G.vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
_G.vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
_G.vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
_G.vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current Buffer" })
local function change_scale_factor(delta)
	_G.vim.g.neovide_scale_factor = (_G.vim.g.neovide_scale_factor * delta)
	return nil
end
local function _5_()
	return change_scale_factor(1.25)
end
_G.vim.keymap.set("n", "<C-=>", _5_)
local function _6_()
	return change_scale_factor((1 / 1.25))
end
_G.vim.keymap.set("n", "<C-->", _6_)
local function _7_()
	_G.vim.g.neovide_scale_factor = 1
	return nil
end
return _G.vim.keymap.set("n", "<C-[>", _7_)
