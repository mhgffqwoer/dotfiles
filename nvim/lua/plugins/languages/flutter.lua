return {
	{
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		opts = {
			lsp = {
				color = {
					enabled = true,
					background = true,
					virtual_text = false,
				},
				settings = {
					showTodos = false,
					renameFilesWithClasses = "always",
					updateImportsOnRename = true,
					completeFunctionCalls = true,
					lineLength = 100,
				},
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "dart" } },
	},
}
