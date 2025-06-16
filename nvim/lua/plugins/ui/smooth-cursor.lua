local M = {}

M.config = function()
	require('smoothcursor').setup({
		type = "default",
		cursor = "▷",
		texthl = "SmoothCursor",
		linehl = nil,
		autostart = true,
		always_redraw = true,
		flyin_effect = nil,
		speed = 100,
		intervals = 35,
		priority = 10,
		timeout = 3000,
		threshold = 0,
		max_threshold = nil,
		disable_float_win = false,
		enabled_filetypes = nil,
		disabled_filetypes = { "lazy", "dashboard", "neo-tree", "neo-tree-popup", "notify", "markdown" },
		disabled_buftypes = { "nofile", "prompt", "popup" },
		show_last_positions = nil,
	})
end

return M