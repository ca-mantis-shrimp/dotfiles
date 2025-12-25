-- [nfnl] dot_config/remove_nvim/lua/remove_plugins/clearhead.fnl
local function _1_()
	local clearhead = require("clearhead")
	clearhead.setup({})
	vim.keymap.set("n", "<leader>ti", "<cmd>ClearheadInbox<CR>", { desc = "Open Clearhead inbox" })
	vim.keymap.set("n", "<leader>to", "<cmd>ClearheadOpenDir<CR>", { desc = "Open .actions in current dir" })
	local function _2_()
		vim.keymap.set("n", "<leader>tt", clearhead["cycle-state"], { buffer = true, desc = "Cycle task state" })
		vim.keymap.set("n", "<leader>tx", clearhead["set-state"]("x"), { buffer = true, desc = "Mark as completed" })
		vim.keymap.set("n", "<leader>t-", clearhead["set-state"]("-"), { buffer = true, desc = "Mark as in-progress" })
		vim.keymap.set("n", "<leader>t=", clearhead["set-state"]("="), { buffer = true, desc = "Mark as blocked" })
		vim.keymap.set("n", "<leader>t_", clearhead["set-state"]("_"), { buffer = true, desc = "Mark as cancelled" })
		return vim.keymap.set(
			"n",
			"<leader>t<space>",
			clearhead["set-state"](" "),
			{ buffer = true, desc = "Mark as not started" }
		)
	end
	return vim.api.nvim_create_autocmd("FileType", { pattern = "actions", callback = _2_ })
end
return {
	{
		dir = "~/Products/clearhead.nvim",
		name = "clearhead.nvim",
		dependencies = { { "nvim-treesitter/nvim-treesitter" }, { "Olical/nfnl" } },
		ft = "actions",
		cmd = { "ClearheadInbox", "ClearheadOpenDir" },
		config = _1_,
	},
}
