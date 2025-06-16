local M = {}

function M.setup()
	local monokai_opts = require("tools.plugin").opts("monokai-pro.nvim")

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = nil,
		title = "",
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = nil,
		title = "concac",
	})
end

return M
