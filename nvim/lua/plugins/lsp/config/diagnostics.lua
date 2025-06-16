local Icons = require("core.icons")

local M = {}

local function on()
	M.enabled = true
	vim.diagnostic.config({
		-- virtual_text = {
		-- 	spacing = 8,
		-- 	source = "if_many",
		-- 	prefix = "●",
		-- }, -- disable virtual text
		virtual_text = false,
		virtual_lines = true,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			style = "minimal",
			source = true,
			header = "",
			prefix = "",
		},
	})
end

local function off()
	M.enabled = false
	vim.diagnostic.config({
		underline = true,
		virtual_text = false,
		signs = false,
		update_in_insert = false,
	})
end

function M.setup(opts)
	for name, icon in pairs(Icons.diagnostics) do
		name = "DiagnosticSign" .. require("tools.string").capitalize(name)
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = name })
	end
	M.toggle(opts.enabled)

	local map = require("tools.safe_keymap").safe_keymap_set
	map("n", "<leader>td", function()
		M.toggle()
	end, { desc = "Toggle LSP diagnostics" })
end

function M.toggle(value)
	if value == nil then
		M.enabled = not M.enabled
	else
		M.enabled = value
	end
	if M.enabled then
		on()
	else
		off()
	end
end

return M
