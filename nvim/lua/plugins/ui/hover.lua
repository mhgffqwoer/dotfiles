local M = {}

M.config = function()
	require("hover").setup({
		init = function()
			-- Require providers
			require("hover.providers.lsp")
			-- require('hover.providers.gh')
			-- require('hover.providers.gh_user')
			-- require('hover.providers.jira')
			require('hover.providers.dap')
			-- require('hover.providers.fold_preview')
			-- require('hover.providers.diagnostic')
			-- require('hover.providers.man')
			-- require('hover.providers.dictionary')
		end,
		preview_opts = {
			border = "single",
		},
		preview_window = false,
		title = true,
		mouse_providers = {
			"LSP",
		},
		mouse_delay = 1000,
	})
	require("core.plugins_keymap").hover()
end

return M 
