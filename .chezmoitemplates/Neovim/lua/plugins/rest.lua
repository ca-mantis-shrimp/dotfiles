return {
	"jellydn/hurl.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = "hurl",
	opts = {
		debug = false,
		show_notification = false,
		mode = "split",
		formatters = {
			json = { "jq" },
			html = {
				"prettier",
				"--parser",
				"html",
			},
			xml = {
				"tidy",
				"-xml",
				"-i",
				"-q",
			},
		},
		mappings = {
			close = "q",
			next_panel = "<C-n>",
			prev_panel = "<C-p>",
		},
	},
	keys = {
		{ "<leader>A", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
		{ "<leader>a", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
		{ "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
		{ "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
		{ "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
		{ "<leader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
	},
}
