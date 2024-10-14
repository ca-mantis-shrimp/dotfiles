-- [nfnl] Compiled from lua/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
	return (_G.vim.fn.executable("make") == 1)
end
local function _2_()
	return require("project_nvim").setup({})
end
local function _3_()
	local telescope = require("telescope")
	local themes = require("telescope.themes")
	local builtin = require("telescope.builtin")
	telescope.setup({
		defaults = {
			mappings = { i = { ["<c-enter>"] = "to_fuzzy_refine" } },
			extensions = { ["ui-select"] = { themes.get_dropdown() } },
		},
	})
	telescope.load_extension("fzf")
	telescope.load_extension("ui-select")
	telescope.load_extension("projects")
	telescope.load_extension("chezmoi")
	_G.vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	_G.vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	_G.vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	_G.vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect [T]elescope" })
	_G.vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	_G.vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
	_G.vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	_G.vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
	local function _4_()
		return telescope.extensions.projects.projects({})
	end
	_G.vim.keymap.set("n", "<leader>sp", _4_, { desc = "[S]earch Recent [p]rojects" })
	_G.vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files for repeat" })
	return _G.vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Search buffers" })
end
return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = _1_ },
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = _G.vim.g.have_nerd_font },
		{ "ahmedkhalf/project.nvim", config = _2_ },
		{ "xvzc/chezmoi.nvim", config = true },
	},
	config = _3_,
}
