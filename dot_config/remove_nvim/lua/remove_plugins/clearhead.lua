-- [nfnl] dot_config/remove_nvim/lua/remove_plugins/clearhead.fnl
local function _1_()
	local clearhead = require("clearhead")
	clearhead.setup({})
	vim.keymap.set("n", "<leader>ti", "<cmd>ClearheadInbox<CR>", { desc = "Open Clearhead inbox" })
	return vim.keymap.set("n", "<leader>to", "<cmd>ClearheadOpenDir<CR>", { desc = "Open .actions in current dir" })
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
