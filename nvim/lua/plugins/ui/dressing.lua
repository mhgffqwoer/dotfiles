local M = {}

M.init = function()
	---@diagnostic disable-next-line: duplicate-set-field
	vim.ui.select = function(...)
		require("lazy").load({ plugins = { "dressing.nvim" } })
		return vim.ui.select(...)
	end
	---@diagnostic disable-next-line: duplicate-set-field
	vim.ui.input = function(...)
		require("lazy").load({ plugins = { "dressing.nvim" } })
		return vim.ui.input(...)
	end
end

M.opts = function()
	local monokai_opts = require("tools.plugin").opts("monokai-pro.nvim")
	local border_style = vim.tbl_contains(monokai_opts.background_clear or {}, "float_win") and "rounded" or "thick"
	return {
	  input = {
		border = require("tools.ui").borderchars(border_style, "tl-t-tr-r-br-b-bl-l"),
		win_options = { winblend = 0 },
	  },
	  select = {},
	}
end

return M
