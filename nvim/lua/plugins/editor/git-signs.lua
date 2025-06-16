local M = {}

M.opts = {
	signs = {
		add = { text = Icons.gitsigns.add },
		change = { text = Icons.gitsigns.change },
		delete = { text = Icons.gitsigns.delete },
		topdelhfe = { text = Icons.gitsigns.topdelete },
		changedelete = { text = Icons.gitsigns.changedelete },
		untracked = { text = Icons.gitsigns.untracked },
	},
	current_line_blame = false,
	current_line_blame_opts = {
		delay = 300,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	preview_config = {
		border = require("tools.ui").borderchars("thick", "tl-t-tr-r-br-b-bl-l"), -- [ top top top - right - bottom bottom bottom - left ]
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local map = require("tools.safe_keymap").safe_keymap_set

		-- Actions
		map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset current hunk" })
		map("v", "<leader>gr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Reset visual selection" })
		map("n", "<leader>ga", gs.stage_buffer, { desc = "Git add current file" })
		map("n", "<leader>gu", gs.reset_buffer_index, { desc = "Git restore current file" })
		map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset current file" })
		map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview current hunk changes" })
		map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame for current line" })
		map("n", "<leader>gd", function()
			gs.diffthis()
			vim.cmd("wincmd x")
			vim.cmd("setlocal nobuflisted")
			vim.cmd("wincmd h")
		end, { desc = "Diff current file" })
	end,
}

return M