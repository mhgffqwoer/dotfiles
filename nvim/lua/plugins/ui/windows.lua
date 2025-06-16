local M = {}

M.keys = require("core.plugins_keymap").windows

M.opts = {
	animation = { enable = true, duration = 150, fps = 60 },
	autowidth = {
		enable = false,
	},
}

M.init = function()
	vim.o.winwidth = 30
	vim.o.winminwidth = 30
	vim.o.equalalways = true
end

return M
