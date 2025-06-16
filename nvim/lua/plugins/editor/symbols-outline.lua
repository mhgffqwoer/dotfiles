local Icons = require("core.icons")

local function hideCursor()
	if vim.g.smear_cursor == true then
		require("smear_cursor").toggle()
		vim.g.smear_cursor = false
	end

	vim.cmd([[
    setlocal guicursor=n:block-Cursor
    setlocal foldcolumn=0
    hi Cursor blend=100
  ]])
end
local function showCursor()
	if vim.g.smear_cursor == false then
		require("smear_cursor").toggle()
		vim.g.smear_cursor = true
	end

	vim.cmd([[
    setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
    hi Cursor blend=0
  ]])
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertEnter", "FileType" }, {
	pattern = "Outline",
	callback = function()
		if vim.bo.filetype == "Outline" then
			hideCursor()
		end
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
	pattern = "Outline",
	callback = function()
		showCursor()
	end,
})
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "Outline" then
			vim.cmd("SymbolsOutlineClose")
		end
	end,
})
vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, {
	pattern = "Outline",
	callback = function()
		if vim.bo.filetype == "Outline" then
			local node = require("symbols-outline")._current_node()
			vim.api.nvim_win_set_cursor(require("symbols-outline").state.code_win, { node.line + 1, node.character })
		end
	end,
})

local M = {}

M.keys = require("core.plugins_keymap").symbols_outline

M.opts = {
	auto_close = false,
	auto_open = true,
	auto_update = true,
	preview_bg_highlight = "FloatBg",
	width = 25,
	highlight_hovered_item = false,
	show_guides = true,
	auto_preview = false,
	position = "right",
	relative_width = false,
	show_numbers = false,
	show_relative_numbers = false,
	show_symbol_details = false,
	autofold_depth = nil,
	auto_unfold_hover = true,
	fold_markers = { "", "" },
	wrap = false,
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = { "<Esc>", "q" },
		goto_location = "<Cr>",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File = { icon = Icons.kinds.File, hl = "@text.uri" },
		Module = { icon = Icons.kinds.Module, hl = "@namespace" },
		Namespace = { icon = Icons.kinds.Namespace, hl = "@namespace" },
		Package = { icon = Icons.kinds.Package, hl = "@namespace" },
		Class = { icon = Icons.kinds.Class, hl = "@type" },
		Method = { icon = Icons.kinds.Method, hl = "@function" },
		Property = { icon = Icons.kinds.Property, hl = "@method" },
		Field = { icon = Icons.kinds.Field, hl = "@field" },
		Constructor = { icon = Icons.kinds.Constructor, hl = "@function" },
		Enum = { icon = Icons.kinds.Enum, hl = "@type" },
		Interface = { icon = Icons.kinds.Interface, hl = "@type" },
		Function = { icon = Icons.kinds.Function, hl = "@function" },
		Variable = { icon = Icons.kinds.Variable, hl = "@constant" },
		Constant = { icon = Icons.kinds.Constant, hl = "@constant" },
		String = { icon = Icons.kinds.String, hl = "@string" },
		Number = { icon = Icons.kinds.Number, hl = "@number" },
		Boolean = { icon = Icons.kinds.Boolean, hl = "@boolean" },
		Array = { icon = Icons.kinds.Array, hl = "@constant" },
		Object = { icon = Icons.kinds.Object, hl = "@type" },
		Key = { icon = Icons.kinds.Key, hl = "@type" },
		Null = { icon = Icons.kinds.Null, hl = "@type" },
		EnumMember = { icon = Icons.kinds.EnumMember, hl = "@field" },
		Struct = { icon = Icons.kinds.Struct, hl = "@type" },
		Event = { icon = Icons.kinds.Event, hl = "@type" },
		Operator = { icon = Icons.kinds.Operator, hl = "@operator" },
		TypeParameter = { icon = Icons.kinds.TypeParameter, hl = "@parameter" },
		Component = { icon = Icons.kinds.Component, hl = "@function" },
		Fragment = { icon = Icons.kinds.Fragment, hl = "@constant" },
	},
}

return M
