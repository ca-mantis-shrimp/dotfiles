-- [nfnl] Compiled from lua/plugins/rest.fnl by https://github.com/Olical/nfnl, do not edit.
return {
	"jellydn/hurl.nvim",
	ft = "hurl",
	opts = {
		mode = "split",
		formatters = { json = { "jq" }, html = { "prettier", "--parse", "html" }, xml = { "tidy", "-xml", "-i", "-q" } },
		mappings = { close = "q", next_panel = "<C-n>", prev_panel = "<C-p>" },
		debug = false,
		show_notification = false,
	},
	keys = {
		{ "<leader>A", "<cmd>HurlRunner<CR>", desc = "Run all requests" },
		{ "<leader>a", "<cmd>HurlRunnerAt<CR>", desc = "Run API Request" },
		{ "<leader>te", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
		{ "<leader>tm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
		{ "<leader>tv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
		{ "<leader>h", "HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
	},
}
