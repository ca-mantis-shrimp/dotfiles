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
