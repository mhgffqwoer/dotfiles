local M = {}

M.keys = require("core.plugins_keymap").notify

M.opts = {
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
}

M.init = function()
	if not require("tools.plugin").has("noice.nvim") then
		vim.notify = require("notify")
	end
end

return M