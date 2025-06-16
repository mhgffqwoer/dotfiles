local M = {}

M.opts = {
	delay = function(ctx)
		return ctx.plugin and 0 or 10
	end,
	win = {
		padding = { 1, 2 },
		wo = { winblend = 10 },
	},
	keys = {
		scroll_down = "<Down>",
		scroll_up = "<Up>",
	},
	layout = {
		height = { min = 3, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 100 }, -- min and max width of the columns
		spacing = 5, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	sort = { "group", "manual" },
	icons = {
		breadcrumb = "»",
		separator = "->",
		group = "+",
		ellipsis = "…",
		mappings = false,
	},
	defaults = {},
	spec = {
		mode = { "n", "v" },
		{ "<leader>g", group = "+Git" },
		-- 	{ "<leader>s", group = "+Session" },
		-- 	--{ "<leader>c", group = "+ChatGPT" },
		-- 	{ "<leader>l", group = "+LSP" },
		-- 	{ "<leader>h", group = "+Help" },
		-- 	{ "<leader>t", group = "+Toggle" },
		-- 	{ "<leader>m", group = "+Markdown" },
		-- 	{ "<leader>n", group = "+Neogen" },
		{ "f", group = "+Fold" },
		{ "g", group = "+Goto" },
		{ "b", group = "+DAP" },
		-- 	{ "s", group = "+Search" },
		-- 	{ "o", group = "+OrderBy" },
		-- 	{ "k", group = "+explorer" },
	},
	triggers = {
		{ "<leader>", mode = { "n", "v" } },
		-- { "[", group = "prev" },
		-- { "]", group = "next" },
		{ "f", mode = { "n" } },
		-- { "s", mode = { "n" } }, -- search group
		{ "o", mode = { "n" } },
		{ "b", mode = { "n" } },
		{ "g", mode = { "n", "v" } }, -- search group
		{ "]", mode = { "n" } },
		{ "[", mode = { "n" } },
	},
	show_help = false, -- show a help message in the command line for using WhichKey
	show_keys = false, -- show the currently pressed key and its label as a message in the command line
	disable = {
		ft = { "lazy", "dashboard" },
	},
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false, -- default bindings on <c-w>
			nav = false, -- misc bindings to work with windows
			z = false, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	},
}

M.config = function(_, opts)
	local wk = require("which-key")
	wk.setup(opts)
end

return M
