local M = {}

M.config = function()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go" },
		sync_install = true,
		auto_install = true,
		tree_docs = { enable = true },
		highlight = { enable = true },
		indent = { enable = true },
		rainbow = {
			enable = true,
			query = "rainbow-parens",
			disable = { "jsx", "html" },
		},
	})
end

return M
