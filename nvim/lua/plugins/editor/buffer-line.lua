local M = {}

M.keys = require("core.plugins_keymap").buffer_line

M.opts = function()
	local monokai_opts = require("tools.plugin").opts("monokai-pro.nvim")
	return {
		options = {
			mode = "buffers",
			diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
			--separator_style = "padded_slant", -- | "thick" | "thin" | "slope" | { 'any', 'any' },
			--separator_style = { "", "" }, -- | "thick" | "thin" | { 'any', 'any' },
			separator_style = "thick", -- | "thick" | "thin" | { 'any', 'any' },
			indicator = {
				-- icon = " ",
				-- style = 'icon',
				style = "none", -- "underline",
			},
			tab_size = 20,
			buffer_close_icon = "", --"󰅖",
			modified_icon = "", --"●",
			close_icon = "", --"󰅖",
			left_trunc_marker = "...",
			right_trunc_marker = "...",
			truncate_names = true,
			diagnostics_indicator = "",
			close_command = function(bufnr)
				local buffers = vim.fn.getbufinfo({ buflisted = 1 })
				if #buffers == 1 or #buffers == 0 then
					require("bufdelete").bufdelete(0, false)
					vim.cmd("q!") -- Закрывает Neovim, если остался последний буфер
				else
					require("bufdelete").bufdelete(bufnr, false)
				end
			end,
			hide = {

			},
			offsets = {
				{
					filetype = "neo-tree",
					text = "EXPLORER",
					text_align = "center",
					separator = vim.tbl_contains(monokai_opts.background_clear or {}, "neo-tree"), -- set to `true` if clear background of neo-tree
				},
				{
					filetype = "dapui_scopes",
					text = "DAP",
					text_align = "center",
					separator = vim.tbl_contains(monokai_opts.background_clear or {}, "Dapui_scopes"), -- set to `true` if clear background of Dapui_scopes
				},
				-- {
				-- 	filetype = "Outline",
				-- 	text = "OUTLINE",
				-- 	text_align = "center",
				-- 	separator = false
				-- 	--separator = vim.tbl_contains(monokai_opts.background_clear or {}, "Outline"), -- set to `true` if clear background of Outline
				-- }
			},
			hover = {
				enabled = true,
				delay = 0,
				reveal = { "close" },
			},
		},
	}
end

return M
