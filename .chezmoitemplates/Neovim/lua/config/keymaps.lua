require("which-key").add({
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

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set("n", "<C-=>", function()
	change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
	change_scale_factor(1 / 1.25)
end)
vim.keymap.set("n", "<C-[>", function()
	vim.g.neovide_scale_factor = 1.0
end)

vim.keymap.set("n", "<leader><tab>c", "<cmd>tcd ~/.local/share/chezmoi<CR>", { desc = "CD to chezmoi in current tab" })
vim.keymap.set("n", "<leader><tab>r", "<cmd>tcd -<CR>", { desc = "CD to previous directory in current tab" })
vim.keymap.set("n", "<leader><tab>b", "<cmd>tcd %:p:h<CR>", { desc = "CD to [B]uffer Directory" })

vim.keymap.set("n", "<leader><tab>a", function()
	os.execute("chezmoi apply")
end, { desc = "Apply to Chezmoi" })
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save current Buffer" })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Start Lazy" })
vim.keymap.set("n", "<leader>un", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss All Notifications" })

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Add current file to harpoon list" })
vim.keymap.set("n", "<leader>H", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon Quick Menu" })

vim.keymap.set("n", "<C-1>", function()
	harpoon:list():select(1)
end, { desc = "Select Harpoon item 1" })
vim.keymap.set("n", "<C-2>", function()
	harpoon:list():select(2)
end, { desc = "Select Harpoon item 2" })
vim.keymap.set("n", "<C-3>", function()
	harpoon:list():select(3)
end, { desc = "Select Harpoon item 3" })
vim.keymap.set("n", "<C-4>", function()
	harpoon:list():select(4)
end, { desc = "Select Harpoon item 4" })
vim.keymap.set("n", "<leader>se", "<cmd>Telescope neorg search_headings<CR>")
vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<CR>")
vim.keymap.set("n", "<leader>nT", "<cmd>Neorg tangle current-file<CR>")
vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<CR>")
