-- [nfnl] neovim/plugins/testing.fnl
local function _1_()
	return require("neotest").run.run()
end
local function _2_()
	return require("neotest").run.run(_G.vim.fn.expand("%"))
end
local function _3_()
	return require("neotest").run.run({ suite = true })
end
local function _4_()
	return require("neotest").summary.toggle()
end
local function _5_()
	return require("neotest").setup({
		adapters = { require("neotest-python")({ dap = { justMyCode = false } }), require("neotest-plenary") },
	})
end
return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-plenary",
	},
	keys = {
		{ "<space>tn", _1_, desc = "[t]est the [n]earest case" },
		{ "<space>tf", _2_, desc = "[t]est the current [f]ile" },
		{ "<space>ts", _3_, desc = "[t]est the [s]uite" },
		{ "<leader>ut", _4_, desc = "[u]i to [t]oggle neotest [s]ummary" },
	},
	config = _5_,
}
