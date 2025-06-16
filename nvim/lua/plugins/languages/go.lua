return {
	-- Ensure Go tools are installed
	{
		name = "mason",
		enabled = true,
		url = "https://github.com/williamboman/mason.nvim",
		lazy = false,
		opts = { ensure_installed = { "goimports", "golangci-lint", "delve" } },
	},
	{
		name = "treesitter",
		enabled = true,
		url = "https://github.com/nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = {
			ensure_installed = { "go", "gomod", "gowork", "gosum" },
			folding = {
				enable = true,
				disable = {}, -- Не отключаем ни для каких языков
			},
		},
	},
	{
		name = "dap",
		enabled = true,
		url = "https://github.com/mfussenegger/nvim-dap",
		lazy = false,
		config = function() 
			local dap = require("dap")
			dap.adapters.go = {
				type = 'server',
				port = 38697,  -- Порт для общения с Delve
				executable = {
					command = 'dlv',
					args = { 'dap', '--listen=:38697', '--headless=true', '--log=false' }
				}
			}
			dap.configurations.go = {
				{
					name = 'Debug project',
					type = 'go',
					request = 'launch',
					program = '${workspaceFolder}/cmd/main.go',  -- Путь к Go-файлу
				},
				{
					name = 'Debug file',
					type = 'go',
					request = 'launch',
					program = '${file}',  -- Путь к Go-файлу
				},
				{
					name = 'Debug project (Arguments)',
					type = 'go',
					request = 'launch',
					program = '${workspaceFolder}/cmd/main.go',  -- Путь к Go-файлу
					args = require("tools.dap").get_arguments
				},
				{
					name = 'Debug file (Arguments)',
					type = 'go',
					request = 'launch',
					program = '${file}',  -- Путь к Go-файлу
					args = require("tools.dap").get_arguments
				},
			}
		end,
	},
	{
		name = "lspconfig",
		enabled = true,
		url = "https://github.com/neovim/nvim-lspconfig",
		lazy = false,
		opts = {
			servers = {
				gopls = {
					opts = {
						settings = {
							gopls = {
								gofumpt = true,
								codelenses = {
									gc_details = true,
									generate = true,
									regenerate_cgo = true,
									run_govulncheck = true,
									test = true,
									tidy = true,
									upgrade_dependency = true,
									vendor = true,
								},
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
								analyses = {
									nilness = true,
									unusedparams = true,
									unusedwrite = true,
									useany = true,
								},
								usePlaceholders = true,
								completeUnimported = true,
								staticcheck = true,
								directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
								semanticTokens = true,
							},
						},
					},
					on_attach = function(client, _)
						if not client.server_capabilities.semanticTokensProvider then
							local semantic = client.config.capabilities.textDocument.semanticTokens
							client.server_capabilities.semanticTokensProvider = {
								full = true,
								legend = {
									tokenTypes = semantic.tokenTypes,
									tokenModifiers = semantic.tokenModifiers,
								},
								range = true,
							}
						end
					end,
					root_dir = { "go.mod", ".git" },
				},
			},
		},
	},
	{
		name = "conform",
		enabled = true,
		url = "https://github.com/stevearc/conform.nvim",
		lazy = false,
		opts = {
			formatters_by_ft = {
				go = { "goimports" },
			},
		},
	},
}
