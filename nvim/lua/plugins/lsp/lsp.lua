local M = {}

M.opts = {
	servers = {
		html = {},
		lua_ls = {
			opts = {
				settings = {
					Lua = {
						hint = { enable = true },
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
						codeLens = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						doc = {
							privateName = { "^_" },
						},
						misc = {
							parameters = {
								"--log-level=trace",
							},
						},
						format = {
							enable = false,
							defaultConfig = {
								indent_style = "space",
								indent_size = "2",
								continuation_indent_size = "2",
							},
						},
					},
				},
			},
		},
	},
	capabilities = {
		textDocument = {
			foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
			completion = {
				completionItem = {
					documentationFormat = { "markdown", "plaintext" },
					snippetSupport = true,
					preselectSupport = true,
					insertReplaceSupport = true,
					labelDetailsSupport = true,
					deprecatedSupport = true,
					commitCharactersSupport = true,
					tagSupport = { valueSet = { 1 } },
					resolveSupport = {
						properties = {
							"documentation",
							"detail",
							"additionalTextEdits",
						},
					},
				},
			},
		},
	},
	diagnostics = { enabled = true },
	inlay_hints = { enabled = true },
	codelens = { enabled = true },
	document_highlight = { enabled = false },
}

M.config = function(_, opts)
	local ok, lspconfig = pcall(require, "lspconfig")
	if not ok then
		require("tools.notify").notify("Plugin `neovim/nvim-lspconfig` not installed", "ERROR")
		return
	end

	require("tools.lsp").setup()

	-- UI
	require("plugins.lsp.config.ui").setup()

	-- Diagnostics
	require("plugins.lsp.config.diagnostics").setup(opts.diagnostics)

	-- Inlay Hints
	require("plugins.lsp.config.inlay_hints").setup(opts.inlay_hints)

	-- Codelens
	require("plugins.lsp.config.codelens").setup(opts.codelens)

	-- Document Highlight
	require("plugins.lsp.config.document_highlight").setup(opts.document_highlight)

	-- Keymaps
	require("tools.lsp").on_attach(function(client, bufnr)
		require("plugins.lsp.config.keymaps").attach(client, bufnr)
		require("plugins.lsp.config.navic").attach(client, bufnr)
	end)

	local servers = opts.servers
	-- Gets a new ClientCapabilities object describing the LSP client capabilities.
	local client_capabilites = vim.lsp.protocol.make_client_capabilities()

	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		client_capabilites,
		require("cmp_nvim_lsp").default_capabilities(),
		opts.capabilities or {}
	)

	--- Setup a LSP server
	---@param server string The name of the server
	local function setup(server)
		-- resolve server capabilities
		if servers[server] and servers[server].capabilities and type(servers[server].capabilities) == "function" then
			servers[server].capabilities = servers[server].capabilities() or {}
		end

		local server_config = servers[server] or { opts = {} }
		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = vim.deepcopy(capabilities),
		}, server_config.opts or {})

		if server_config.on_attach then
			local function callback(client, bufnr)
				if client.name == server then
					server_config.on_attach(client, bufnr)
				end
			end
			require("tools.lsp").on_attach(callback)
		end

		local pending = true
		if not pending and server_opts.root_dir then
			-- If root_dir is string or list of strings
			local lsp_utils = require("lspconfig/util")
			if type(server_opts.root_dir) == "string" then
				server_opts.root_dir = lsp_utils.root_pattern(server_opts.root_dir)
			end
			if type(server_opts.root_dir) == "table" then
				server_opts.root_dir = lsp_utils.root_pattern(server_opts.root_dir)
			end
		end
		if pending then
			server_opts.root_dir = nil
		end

		lspconfig[server].setup(server_opts)
	end

	local available = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

	local ensure_installed = {}
	for server, server_opts in pairs(servers) do
		if server_opts then
			if server_opts.enabled ~= false then
				if not vim.tbl_contains(available, server) then
					setup(server)
				else
					ensure_installed[#ensure_installed + 1] = server
				end
			end
		end
	end

	require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
	require("mason-lspconfig").setup_handlers({ setup })
end

return M
