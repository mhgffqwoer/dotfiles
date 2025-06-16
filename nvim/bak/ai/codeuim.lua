return {
	{
		"Exafunction/codeium.nvim",
		lazy = false,
		enabled = false,
		event = { "InsertEnter" },
		build = ":Codeium Auth",
		-- keys = {
		-- 	{
		-- 		"<leader>tC",
		-- 		function()
		-- 			vim.g.codeium_virtual_text = not vim.g.codeium_virtual_text
		-- 			require("codeium").setup({
		-- 				virtual_text = { enabled = vim.g.codeium_virtual_text },
		-- 			})
		-- 			print("Virtual text is now " .. (vim.g.codeium_virtual_text and "enabled" or "disabled"))
		-- 		end,
		-- 		desc = "Codeium Toggle Virtual Text",
		-- 		remap = true,
		-- 	},
		-- },
		opts = {
			config_path = "~/.codeium/api.txt",
			enable_chat = true,
			virtual_text = { enabled = true },
		},
		-- init = function()
		-- 	require("codeium").setup({
		-- 		virtual_text = { enabled = vim.g.codeium_virtual_text },
		-- 	})
		-- end,
	},
}