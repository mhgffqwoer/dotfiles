local Icons = require("core.icons")

return {
		{
		"utilyre/barbecue.nvim",
		lazy = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			attach_navic = false,
			theme = "auto",
			include_buftypes = { "" },
			exclude_filetypes = { "gitcommit", "Trouble", "toggleterm", "Outline" },
			show_modified = false,
			kinds = Icons.kinds,
		},
	},
}