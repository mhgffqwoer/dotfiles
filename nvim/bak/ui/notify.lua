local Icons = require("core.icons")

return {
	{
		"rcarriga/nvim-notify",
		lazy = false,
		keys = {
			{
				"<leader>n",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Clear all notifications",
			},
		},
		opts = {
			icons = {
				ERROR = Icons.diagnostics.error .. " ",
				INFO = Icons.diagnostics.info .. " ",
				WARN = Icons.diagnostics.warn .. " ",
			},
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			vim.notify = require("notify")
		end,
	},

	{
		"folke/noice.nvim",
		lazy = false,
		event = "VeryLazy",
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline",
				format = {
					cmdline = { icon = "  " },
					search_down = { icon = " 🔍 󰄼" },
					search_up = { icon = " 🔍 " },
					help = { icon = " 󰋖" },
					lua = { icon = "  " },
				},
			},
			lsp = {
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					view = "mini",
				},
				hover = { enabled = false },
				signature = { enabled = false },
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "No active Snippet" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "Hunk" },
						},
					},
					view = "mini",
				},
				{
					filter = {
						event = "notify",
						any = {
							{ find = "No information available" },
						},
					},
				},
			},
		},
	},
}