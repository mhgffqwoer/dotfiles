local M = {}

function M.setup(opts)
	opts = opts or {}
	if not opts.enabled then
		return
	end
	require("tools.lsp").on_support_methods("textDocument/codeLens", function(client, buffer)
		vim.lsp.codelens.refresh()
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			buffer = buffer,
			callback = vim.lsp.codelens.refresh,
		})
	end)
end

return M
