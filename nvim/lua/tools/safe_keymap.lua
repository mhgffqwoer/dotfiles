local M = {}

function M.safe_keymap_set(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	local modes = type(mode) == "string" and { mode } or mode

	---@param m string
	modes = vim.tbl_filter(function(m)
		return not (keys.have and keys:have(lhs, m))
	end, modes)

	if #modes > 0 then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			---@diagnostic disable-next-line: no-unknown
			opts.remap = nil
		end
		vim.keymap.set(modes, lhs, rhs, opts)
	end
end

return M