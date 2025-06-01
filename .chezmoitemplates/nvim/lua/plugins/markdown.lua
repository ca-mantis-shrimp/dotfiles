-- [nfnl] lua/plugins/markdown.fnl
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { { "nvim-treesitter/nvim-treesitter" }, { "echasovski/mini.nvim" } },
		opts = { file_types = { "markdown", "Avante" } },
		ft = { "markdown", "Avante" },
	},
}
