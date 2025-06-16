local M = {}

M.config = function()
	require("nvim-highlight-colors").setup({
		render = "background", -- или 'foreground' для цвета текста
		enable_named_colors = true,
	})
end

return M