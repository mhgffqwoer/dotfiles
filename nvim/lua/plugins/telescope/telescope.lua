local M = {}

M.keys = require("core.plugins_keymap").telescope

M.config = function()
	require("telescope").setup({
		defaults = {
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "   ",
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = { mirror = false },
				width = 0.8,
				height = 0.80,
				preview_cutoff = 120,
			},
			mappings = {
				n = {
					["q"] = require("telescope.actions").close,
				},
				i = {
					["<esc>"] = require("telescope.actions").close
				},
			},
		},
	})
end

return M
