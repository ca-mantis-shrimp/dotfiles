-- [nfnl] Compiled from lua/plugins/git.fnl by https://github.com/Olical/nfnl, do not edit.
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "\226\128\190" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
		config = true,
		keys = { { "<leader>g", "<cmd>Neogit<CR>", desc = "NeoGit" } },
	},
}
