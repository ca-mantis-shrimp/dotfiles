return {
	{
		"ThePrimeagen/harpoon",
		config = true,
	},
	{
		"cbochs/portal.nvim",
		dependencies = { "cbochs/grapple.nvim" },
		keys = {
			{ "<leader>o", "<cmd>Portal jumplist backward<cr>", desc = "Open portal for Backwards Jump" },
			{ "<leader>i", "<cmd>Portal jumplist forward<cr>", desc = "Open Portal for Forwards Jump" },
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>j",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"<leader>J",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>O", "<cmd>Oil<cr>", desc = "Open Oil" },
		},
	},
	{
		"https://git.sr.ht/~swaits/scratch.nvim",
		lazy = true,
		keys = {
			{ "<leader>bs", "<cmd>Scratch<cr>", desc = "Scratch Buffer", mode = "n" },
			{ "<leader>bS", "<cmd>ScratchSplit<cr>", desc = "Scratch Buffer (split)", mode = "n" },
		},
		cmd = {
			"Scratch",
			"ScratchSplit",
		},
		opts = {},
	},
}
