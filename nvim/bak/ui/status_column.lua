return {
	-- fold plugin
	{
		"kevinhwang91/nvim-ufo",
		lazy = false,
		event = "VimEnter",
		dependencies = { "kevinhwang91/promise-async", event = "VimEnter" },
		opts = {
			open_fold_hl_timeout = 0,
			provider_selector = function(bufnr, filetype, buftype)
				if filetype == "neotest-summary" then
					return ''
				end
				if filetype == "neo-tree" then
					return ''
				end
				if filetype == "Outline" then
					return ''
				end
				return { "treesitter", "indent" }
			end,
		},
		keys = {
			{ "fd", "zd", desc = "Delete fold under cursor" },
			{ "fo", "zo", desc = "Open fold under cursor" },
			{ "fO", "zO", desc = "Open all folds under cursor" },
			{ "fc", "zC", desc = "Close all folds under cursor" },
			{ "fa", "za", desc = "Toggle fold under cursor" },
			{ "fA", "zA", desc = "Toggle all folds under cursor" },
			{ "fv", "zv", desc = "Show cursor line" },
			{
				"fM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds",
			},
			{
				"fR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
			},
			{
				"fm",
				function()
					require("ufo").closeFoldsWith()
				end,
				desc = "Fold more",
			},
			{
				"fr",
				function()
					require("ufo").openFoldsExceptKinds()
				end,
				desc = "Fold less",
			},
			{ "fx", "zx", desc = "Update folds" },
			{ "fz", "zz", desc = "Center this line" },
			{ "ft", "zt", desc = "Top this line" },
			{ "fb", "zb", desc = "Bottom this line" },
			{ "fg", "zg", desc = "Add word to spell list" },
			{ "fw", "zw", desc = "Mark word as bad/misspelling" },
			{ "fe", "ze", desc = "Right this line" },
			{ "fE", "zE", desc = "Delete all folds in current buffer" },
			{ "fs", "zs", desc = "Left this line" },
			{ "fH", "zH", desc = "Half screen to the left" },
			{ "fL", "zL", desc = "Half screen to the right" },
		},
	},

	-- status columns
	{
		"luukvbaal/statuscol.nvim",
		lazy = false,
		event = { "VimEnter" }, -- Enter when on Vim startup to setup folding correctly (Avoid number in fold column)
		commit = (function()
			if vim.fn.has("nvim-0.9") == 1 then
				return "483b9a596dfd63d541db1aa51ee6ee9a1441c4cc"
			end
		end)(),
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = false,
				ft_ignore = { "neo-tree", "Outline", "neotest-summary" },
				segments = {
					{ text = { "%s" },                  click = "v:lua.ScSa" }, -- Sign
					{
						-- line number
						text = { " ", builtin.lnumfunc },
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- Fold
				},
			})
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				callback = function()
					if vim.bo.filetype == "neo-tree" or vim.bo.filetype == "Outline" or vim.bo.filetype == "neotest-summary" then
						vim.opt_local.statuscolumn = ""
					end
				end,
			})
		end,
	},

	{
		"petertriho/nvim-scrollbar",
		lazy = false,
		--event = { "BufReadPost", "BufNewFile" },
		event = "VeryLazy",
		opts = {
			set_highlights = false,
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
				"noice",
				"neo-tree",
				"dashboard",
				"alpha",
				"lazy",
				"mason",
				"DressingInput",
				"Outline",
				"gitcommit",
				"gitgraph",
			},
			handlers = {
				gitsigns = true,
			},
		},
	},

	{
		"kosayoda/nvim-lightbulb",
		lazy = false,
		opts = {
			sign = {
				enabled = true,
				-- Priority of the gutter sign
				priority = 20,
			},
			status_text = {
				enabled = true,
				-- Text to provide when code actions are available
				text = "status_text",
				-- Text to provide when no actions are available
				text_unavailable = "",
			},
			autocmd = {
				enabled = true,
				-- see :help autocmd-pattern
				pattern = { "*" },
				-- see :help autocmd-events
				events = { "CursorHold", "CursorHoldI", "LspAttach" },
			},
		},
	},
}
