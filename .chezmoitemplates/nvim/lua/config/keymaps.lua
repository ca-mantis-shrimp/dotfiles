-- [nfnl] Compiled from lua/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
do
	local wk = require("which-key")
	local function _1_()
		return _G.vim.cmd.edit({
			args = { (_G.vim.fn.fnamemodify(_G.vim.fn.stdpath("data"), ":h") .. "/clhd/main.actions") },
		})
	end
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
		{ "<leader>i", group = "[I]ntentions" },
		{ "<leader>h", desc = "Git [H]unk", mode = "v" },
		{ "<leader>ie", _1_, desc = "Edit clearhead actions file" },
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
local function _2_()
	return change_scale_factor(1.25)
end
_G.vim.keymap.set("n", "<C-=>", _2_)
local function _3_()
	return change_scale_factor((1 / 1.25))
end
_G.vim.keymap.set("n", "<C-->", _3_)
local function _4_()
	_G.vim.g.neovide_scale_factor = 1
	return nil
end
_G.vim.keymap.set("n", "<C-[>", _4_)
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
local function _5_()
	return os.execute("chezmoi apply")
end
_G.vim.keymap.set("n", "<leader><tab>a", _5_, { desc = "Apply to Chezmoi" })
_G.vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current Buffer" })
_G.vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Start Lazy" })
_G.vim.keymap.set("n", "<leader>un", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss All Notifications" })
local harpoon = require("harpoon")
local function _6_()
	return harpoon:list():add()
end
_G.vim.keymap.set("n", "<leader>a", _6_, { desc = "Add current file to harpoon list" })
local function _7_()
	return harpoon.ui:toggle_quick_menu(harpoon:list())
end
_G.vim.keymap.set("n", "<leader>H", _7_, { desc = "Toggle Harpoon Quick Menu" })
local function _8_()
	return harpoon:list():select(1)
end
_G.vim.keymap.set("n", "<C-1>", _8_, { desc = "Select Harpoon item 1" })
local function _9_()
	return harpoon:list():select(2)
end
_G.vim.keymap.set("n", "<C-2>", _9_, { desc = "Select Harpoon item 2" })
local function _10_()
	return harpoon:list():select(3)
end
_G.vim.keymap.set("n", "<C-3>", _10_, { desc = "Select Harpoon item 3" })
local function _11_()
	return harpoon:list():select(4)
end
_G.vim.keymap.set("n", "<C-4>", _11_, { desc = "Select Harpoon item 4" })
local function _12_()
	return harpoon:list():select(5)
end
_G.vim.keymap.set("n", "<C-5>", _12_, { desc = "Select Harpoon item 5" })
local function _13_()
	return harpoon:list():select(6)
end
_G.vim.keymap.set("n", "<C-6>", _13_, { desc = "Select Harpoon item 6" })
_G.vim.keymap.set("n", "<leader>se", "<cmd>Telescope neorg search_headings<CR>")
_G.vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<CR>")
_G.vim.keymap.set("n", "<leader>nT", "<cmd>Neorg tangle current-file<CR>")
_G.vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<CR>")
local function _14_()
	local query = _G.vim.fn.input("Search Google: ")
	if query ~= "" then
		return _G.vim.cmd({ cmd = "OpenBrowserSmartSearch", args = { ("'" .. query .. "'") } })
	else
		return nil
	end
end
_G.vim.keymap.set("n", "<leader>sb", _14_, { desc = "search browser with google" })
local function _16_()
	return require("neotest").run.run()
end
_G.vim.keymap.set("n", "<space>tn", _16_, { desc = "[t]est the [n]earest case" })
local function _17_()
	return require("neotest").run.run(_G.vim.fn.expand("%"))
end
_G.vim.keymap.set("n", "<space>tf", _17_, { desc = "[t]est the current [f]ile" })
local function _18_()
	return require("neotest").run.run({ suite = true })
end
_G.vim.keymap.set("n", "<space>ts", _18_, { desc = "[t]est the [s]uite" })
local function _19_()
	return require("neotest").summary.toggle()
end
_G.vim.keymap.set("n", "<leader>ut", _19_, { desc = "[u]i to [t]oggle neotest [s]ummary" })
_G.vim.keymap.set(
	"n",
	"<leader>uc",
	"<cmd>CodeCompanionChat Toggle<CR>",
	{ desc = "[u]i to toggle code completion [c]hat" }
)
return _G.vim.keymap.set(
	"n",
	"<leader>sA",
	"<cmd>CodeCompanionActions<CR>",
	{ desc = "[s]earch CodeCompanion [a]ctions" }
)
