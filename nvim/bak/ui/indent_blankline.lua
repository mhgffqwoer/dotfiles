return {
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = false,
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = function()
			local hooks = require("ibl.hooks")
			-- hooks.register(hooks.type.SCOPE_ACTIVE, function(bufnr)
			--   return vim.api.nvim_buf_line_count(bufnr) < 2000
			-- end)
			return {
				debounce = 200,
				indent = {
					char = "▏",
					tab_char = "▏",
					-- highlight = "IndentBlanklineChar",
					-- highlight = highlight,
				},
				scope = { enabled = false },
				-- scope = {
				--   injected_languages = true,
				--   highlight = highlight,
				--   enabled = true,
				--   show_start = true,
				--   show_end = false,
				--   char = "▏",
				--   -- include = {
				--   --   node_type = { ["*"] = { "*" } },
				--   -- },
				--   -- exclude = {
				--   --   node_type = { ["*"] = { "source_file", "program" }, python = { "module" }, lua = { "chunk" } },
				--   -- },
				-- },
				exclude = {
					filetypes = {
						"help",
						"startify",
						"dashboard",
						"packer",
						"neogitstatus",
						"NvimTree",
						"Trouble",
						"alpha",
						"neo-tree",
						"Outline",
					},
					buftypes = {
						"terminal",
						"nofile",
					},
				},
			}
		end,
		main = "ibl",
	},
}