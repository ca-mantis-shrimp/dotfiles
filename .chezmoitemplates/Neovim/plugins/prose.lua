-- [nfnl] plugins/prose.fnl
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
		opts = { file_types = { "markdown", "Avante" } },
		ft = { "markdown", "Avante" },
	},
}
