return {

	{
		"cbochs/portal.nvim",
		dependencies = { "cbochs/grapple.nvim" },
		keys = {
			{ "<leader>o", "<cmd>Portal jumplist backward<cr>" },
			{ "<leader>i", "<cmd>Portal jumplist forward<cr>" },
		},
	},

	{
		"folke/noice.nvim",
		cond = not vim.g.started_by_firenvim,
	},

	{
		"ErichDonGubler/lsp_lines.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
			})
			require("lsp_lines").setup()
		end,
		ft = { "lua", "python", "rust" },
	},

	{
		{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	},

	{
		"alker0/chezmoi.vim",
	},

	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "op read op://Back-End/openai_api_key/credential",
				openai_params = {
					model = "gpt-4",
				},
			})
		end,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"folke/trouble.nvim",
		},
	},

	{
		"weirongxu/plantuml-previewer.vim",
		dependencies = { "aklt/plantuml-syntax", "tyru/open-browser.vim" },
	},

	{ "projekt0n/github-nvim-theme" },

	{
		"cameron-wags/rainbow_csv.nvim",
		config = true,
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		},
		cmd = {
			"RainbowDelim",
			"RainbowDelimSimple",
			"RainbowDelimQuoted",
			"RainbowMultiDelim",
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod", lazy = true },
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		keys = {
			{
				"<leader>a",
				function()
					harpoon:list():append()
				end,
				desc = "add current buffer to list",
			},
		},
	},
}

