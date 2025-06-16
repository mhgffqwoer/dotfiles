return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		event = "VeryLazy",
		build = ":TSUpdate",
	},

	{
	  "nvim-treesitter/nvim-treesitter-context",
	  lazy = false,
	  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	  enabled = true,
	  opts = { mode = "cursor", max_lines = 1, zindex = 20 },
	  disable_on_exit = false,
	},
}