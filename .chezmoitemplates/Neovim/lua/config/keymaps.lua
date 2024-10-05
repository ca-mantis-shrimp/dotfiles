-- [nfnl] Compiled from lua/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
do
	local wk = require("which-key")
	wk.add({
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>h", group = "Git [H]unk" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>n", group = "[N]eorg" },
		{ "<leader>l", group = "[L]ists in Neorg" },
		{ "<leader>h", desc = "Git [H]unk", mode = "v" },
	})
end
_G.vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
_G.vim.keymap.set("n", "[d", _G.vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
_G.vim.keymap.set("n", "]d", _G.vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
_G.vim.keymap.set("n", "<leader>e", _G.vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
_G.vim.keymap.set("n", "<leader>q", _G.vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
_G.vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[Esc]ape terminal mode" })
_G.vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
_G.vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
_G.vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
_G.vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
local function change_scale_factor(delta)
	_G.vim.g.neovide_scale_factor = (_G.vim.g.neovide_scale_factor * delta)
	return nil
end
local function _1_()
	return change_scale_factor(1.25)
end
_G.vim.keymap.set("n", "<C-=>", _1_)
local function _2_()
	return change_scale_factor((1 / 1.25))
end
_G.vim.keymap.set("n", "<C-->", _2_)
local function _3_()
	_G.vim.g.neovide_scale_factor = 1
	return nil
end
_G.vim.keymap.set("n", "<C-[>", _3_)
_G.vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "Create New [tab]" })
_G.vim.keymap.set("n", "<leader><tab><Del>", "<cmd>tabclose<CR>", { desc = "[Del]ete Current Tab" })
_G.vim.keymap.set("n", "<leader><tab>n", "<cmd>tabNext<CR>", { desc = "[n]ext Tab" })
_G.vim.keymap.set("n", "<leader><tab>p", "<cmd>tabprevious<CR>", { desc = "[p]revious Tab" })
_G.vim.keymap.set(
	"n",
	"<leader><tab>c",
	"<cmd>tcd ~/.local/share/chezmoi<CR>",
	{ desc = "CD to chezmoi in current tab" }
)
_G.vim.keymap.set("n", "<leader><tab>r", "<cmd>tcd -<CR>", { desc = "CD to previous directory in current tab" })
_G.vim.keymap.set("n", "<leader><tab>b", "<cmd>tcd %:p:h<CR>", { desc = "CD to [B]uffer Directory" })
local function _4_()
	return os.execute("chezmoi apply")
end
_G.vim.keymap.set("n", "<leader><tab>a", _4_, { desc = "Apply to Chezmoi" })
_G.vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current Buffer" })
_G.vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Start Lazy" })
_G.vim.keymap.set("n", "<leader>un", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss All Notifications" })
local harpoon = require("harpoon")
local function _5_()
	return harpoon:list():add()
end
_G.vim.keymap.set("n", "<leader>a", _5_, { desc = "Add current file to harpoon list" })
local function _6_()
	return harpoon.ui:toggle_quick_menu(harpoon:list())
end
_G.vim.keymap.set("n", "<leader>H", _6_, { desc = "Toggle Harpoon Quick Menu" })
local function _7_()
	return harpoon:list():select(1)
end
_G.vim.keymap.set("n", "<C-1>", _7_, { desc = "Select Harpoon item 1" })
local function _8_()
	return harpoon:list():select(2)
end
_G.vim.keymap.set("n", "<C-2>", _8_, { desc = "Select Harpoon item 2" })
local function _9_()
	return harpoon:list():select(3)
end
_G.vim.keymap.set("n", "<C-3>", _9_, { desc = "Select Harpoon item 3" })
local function _10_()
	return harpoon:list():select(4)
end
_G.vim.keymap.set("n", "<C-4>", _10_, { desc = "Select Harpoon item 4" })
local function _11_()
	return harpoon:list():select(5)
end
_G.vim.keymap.set("n", "<C-5>", _11_, { desc = "Select Harpoon item 5" })
local function _12_()
	return harpoon:list():select(6)
end
_G.vim.keymap.set("n", "<C-6>", _12_, { desc = "Select Harpoon item 6" })
_G.vim.keymap.set("n", "<leader>se", "<cmd>Telescope neorg search_headings<CR>")
_G.vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<CR>")
_G.vim.keymap.set("n", "<leader>nT", "<cmd>Neorg tangle current-file<CR>")
_G.vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<CR>")
_G.vim.keymap.set({ "n", "t" }, "<C-x>", "<cmd>ToggleTerm<CR>", { desc = "toggle terminal" })
local function _13_()
	local query = _G.vim.fn.input("Search Google: ")
	if query ~= "" then
		return _G.vim.cmd({ cmd = "OpenBrowserSmartSearch", args = { ("'" .. query .. "'") } })
	else
		return nil
	end
end
_G.vim.keymap.set("n", "<leader>sb", _13_, { desc = "search browser with google" })
_G.vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>", { desc = "[r]epl [s]tart" })
_G.vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>", { desc = "[r]epl [r]estart" })
_G.vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>", { desc = "[r]epl [f]ocus" })
return _G.vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>", { desc = "[r]epl [h]ide" })
