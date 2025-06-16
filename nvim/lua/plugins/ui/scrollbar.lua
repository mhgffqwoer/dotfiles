local M = {}

M.opts = {
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
}

return M