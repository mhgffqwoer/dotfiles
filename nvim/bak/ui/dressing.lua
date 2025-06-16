return {
	{
		"stevearc/dressing.nvim",
		lazy = false,
		event = { "BufReadPost", "BufNewFile" },
		opts = function()
			local monokai_opts = Utils.plugin.opts("monokai-pro.nvim")
			local border_style = vim.tbl_contains(monokai_opts.background_clear or {}, "float_win") and "rounded"
				or "thick"
			return {
				input = {
					border = require("tools.ui").borderchars(border_style, "tl-t-tr-r-br-b-bl-l"),
					win_options = { winblend = 0 },
				},
				select = {},
			}
		end,
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
}