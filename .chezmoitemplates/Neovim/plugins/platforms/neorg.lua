-- [nfnl] plugins/platforms/neorg.fnl
return {
	"nvim-neorg/neorg",
	opts = {
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						main = "~/neorg",
						work_notes = "~/dab_work_neorg_notes",
						knowledge_base = "~/knowledge_base",
						config = "~/.local/share/chezmoi/literate_config",
						journal = "~/journal",
					},
					autochdir = true,
					index = "index.norg",
					last_workspace = (_G.vim.fn.stdpath("cache") .. "/neorg_last_workspace.txt"),
				},
			},
			["core.qol.toc"] = {},
			["core.journal"] = { config = { journal_folder = "/years/", workspace = "journal" } },
			["core.esupports.metagen"] = { config = { type = "auto" } },
			["core.export"] = {},
			["core.export.markdown"] = { config = { extensions = "all" } },
			["core.looking-glass"] = {},
			["core.integrations.otter"] = {},
			["core.summary"] = {},
		},
	},
	keys = {
		{ "<leader>nt", "<cmd>Neorg journal today<cr>", desc = "Today's Journal Page" },
		{ "<leader>nw", "<cmd>Neorg workspace work_notes<cr>", desc = "Edit Work Notes" },
		{ "<leader>nm", "<cmd>Neorg workspace main<cr>", desc = "Edit Primary Notes" },
		{ "<leader>nk", "<cmd>Neorg workspace knowledge_base<cr>", desc = "Edit Knowledge Base" },
		{ "<leader>nc", "<cmd>Neorg workspace config<cr>", desc = "Edit Literate Config" },
		{ "<localLeader>ns", "<cmd>Neorg generate-workspace-summary<cr>", desc = "Generate Workspace Summary" },
		{ "<leader>nr", "<cmd>Neorg return<CR>", desc = "Return from Neorg Workspace" },
		{ "<localLeader>nt", "<cmd>Neorg tangle current-file<CR>", desc = "Tangle Current File" },
		{ "<leader>ni", "<cmd>Neorg index<CR>", desc = "Go to Index of Neorg Workspace" },
	},
	dependencies = { { "jmbuhr/otter.nvim" } },
	lazy = false,
}
