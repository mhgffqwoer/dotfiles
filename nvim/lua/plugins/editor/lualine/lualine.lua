local M = {}

M.opts = function()
	local lualine_require = require("lualine_require")
	lualine_require.require = require
	local monokai_opts = require("tools.plugin").opts("monokai-pro.nvim")
	return {
		float = vim.tbl_contains(monokai_opts.background_clear or {}, "neo-tree"),
		colorful = true,
	}
end

M.config = function(_, opts)
	local lualine = require("plugins.editor.lualine.config")
	lualine.setup(opts)
	lualine.load()
end

return M
