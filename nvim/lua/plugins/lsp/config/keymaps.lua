local M = {}

M._keys = nil

function M.get()
	if M._keys then
		return M._keys
	end
	M._keys = {
		{ "<leader>ll", vim.lsp.buf.code_action,             desc = "[LSP] Code Action" },
		-- stylua: ignore
		{ "<leader>li", "<cmd>LspInfo<cr>",                  desc = "[LSP] Info" },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "[LSP] Rename" },
		-- Goto
		{ "gd",         vim.lsp.buf.definition,              desc = "[LSP] Definition",    has = "definition" },
		{ "gr",         vim.lsp.buf.references,              desc = "[LSP] References",         nowait = true },
		{ "gi",         vim.lsp.buf.implementation,          desc = "[LSP] Implementation" },
		{ "K",          "<cmd>lua vim.lsp.buf.hover()<CR>",  desc = "[LSP] Signature Help" },
		{ "<c-k>",      vim.lsp.buf.signature_help,          mode = "i",                  desc = "[LSP] Signature Help" },
		{ "gl",         vim.diagnostic.open_float,           desc = "[LSP] Diagnostics" },
	}

	return M._keys
end

function M.resolve(bufnr)
	local Keys = require("lazy.core.handler.keys")
	local spec = M.get()

	local opts = require("tools.plugin").opts("lspconfig")
	local clients
	if vim.fn.has("nvim-0.11") == 1 then
		clients = vim.lsp.get_clients({ bufnr = bufnr })
	else
		clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	end
	for _, client in ipairs(clients) do
		local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
		vim.list_extend(spec, maps)
	end
	return Keys.resolve(spec)
end

function M.attach(_, bufnr)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = M.resolve(bufnr)

	for _, keys in pairs(keymaps) do
		local opts = Keys.opts(keys)
		opts.has = nil
		opts.silent = opts.silent ~= false
		opts.buffer = bufnr
		vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
	end
end

return M
