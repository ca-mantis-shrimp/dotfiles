-- [nfnl] Compiled from lua/plugins/neorg.fnl by https://github.com/Olical/nfnl, do not edit.
local dependencies = {
	"nvim-neorg/neorg-telescope",
	{
		"folke/zen-mode.nvim",
		keys = { { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" } },
		config = true,
		dependencies = { "folke/twilight.nvim", config = true },
	},
}
local keys = {
	{ "<leader>nt", "<cmd>Neorg journal today<cr>", desc = "Today's Journal Page" },
	{ "<leader>nw", "<cmd>Neorg workspace work_notes<cr>", desc = "Edit Work Notes" },
	{ "<leader>nm", "<cmd>Neorg workspace main<cr>", desc = "Edit Primary Notes" },
	{ "<leader>nk", "<cmd>Neorg workspace knowledge_base<cr>", desc = "Edit Knowledge Base" },
	{ "<leader>nc", "<cmd>Neorg workspace config<cr>", desc = "Edit Literate Config" },
	{ "<leader>ns", "<cmd>Neorg generate-workspace-summary<cr>", desc = "Generate Workspace Summary" },
}
local dirman_config = {
	config = {
		workspaces = {
			main = "~/neorg",
			work_notes = "~/work_neorg_notes",
			knowledge_base = "~/knowledge_base",
			config = "~/.local/share/chezmoi/literate_config",
			journal = "~/journal",
		},
		autochdir = true,
		index = "index.norg",
		last_workspace = (_G.vim.fn.stdpath("cache") .. "/neorg_last_workspace.txt"),
	},
}
local load = {
	["core.defaults"] = {},
	["core.concealer"] = {},
	["core.dirman"] = dirman_config,
	["core.presenter"] = { config = { zen_mode = "zen-mode" } },
	["core.completion"] = { config = { engine = "nvim-cmp" } },
	["core.qol.toc"] = {},
	["core.journal"] = { config = { journal_folder = "/years/", workspace = "journal" } },
	["core.esupports.metagen"] = { config = { type = "auto" } },
	["core.export"] = {},
	["core.export.markdown"] = { config = { extensions = "all" } },
	["core.integrations.telescope"] = {},
	["core.summary"] = {},
}
local function _1_()
	return require("neorg").setup({ load = load })
end
return { "nvim-neorg/neorg", dependencies = dependencies, keys = keys, config = _1_, lazy = false }
