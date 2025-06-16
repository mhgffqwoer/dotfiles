local M = {}

M.keys = require("core.plugins_keymap").conform

M.opts = {
	formatters_by_ft = {
		lua = { "stylua" },
	},
	formatters = {
		injected = { options = { ignore_errors = true } },
	},
	main = "conform",
}

M.init = function()
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

return M
