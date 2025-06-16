local M = {}

M.opts = function()
	local hooks = require("ibl.hooks")
	hooks.register(hooks.type.SCOPE_ACTIVE, function(bufnr)
	  return vim.api.nvim_buf_line_count(bufnr) < 2000
	end)
	local hl =  "IndentBlanklineChar"
	return {
		debounce = 200,
		indent = {
			char = "▏",
			tab_char = "▏",
			highlight = hl,
			--highlight = highlight,
		},
		--scope = { enabled = true },
		scope = {
		  injected_languages = true,
		  highlight = hl,
		  enabled = false,
		  show_start = true,
		  show_end = false,
		  char = "▏",
		  -- include = {
		  --   node_type = { ["*"] = { "*" } },
		  -- },
		  -- exclude = {
		  --   node_type = { ["*"] = { "source_file", "program" }, python = { "module" }, lua = { "chunk" } },
		  -- },
		},
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
end

return M