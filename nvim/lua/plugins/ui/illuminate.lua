local M = {}

M.keys = {
	{
		"]]",
		function()
			require("illuminate").goto_next_reference()
		end,
		desc = "Next Reference",
	},
	{
		"[[",
		function()
			require("illuminate").goto_prev_reference()
		end,
		desc = "Prev Reference",
	},
}

M.opts = {
	providers = {
		"lsp",
		"treesitter",
		"regex",
	},
	delay = 10,
	filetype_overrides = {},
	filetypes_denylist = {
		"neo-tree",
		"dashboard",
		"Outline",
		"neotest-summary",
		"dirvish",
		"fugitive",
	},
	filetypes_allowlist = {},
	modes_denylist = {},
	modes_allowlist = {},
	providers_regex_syntax_denylist = {},
	providers_regex_syntax_allowlist = {},
	under_cursor = true,
	large_file_cutoff = 15000,
	large_file_overrides = { providers = { "regex" } },
	min_count_to_highlight = 1,
}

M.config = function(_, opts)
	require("illuminate").configure(opts)

	local hl = vim.api.nvim_set_hl
	hl(0, "IlluminatedWordText", { underline = true, sp = "#aaaaaa" }) -- #666666 #444444 #5c6370 #aaaaaa #3c3c3c
	hl(0, "IlluminatedWordRead", { link = "IlluminatedWordText" })
	hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordText" })
end

return M
