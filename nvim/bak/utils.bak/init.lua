local M = {}

setmetatable(M, {
	__index = function(_, k)
		local mod = require("utils." .. k)
		return mod
	end,
})

function M.notify(msg, level, opts)
	opts = opts or {}
	level = vim.log.levels[level:upper()]
	if type(msg) == "table" then
		msg = table.concat(msg, "\n")
	end
	local nopts = { title = "Nvim" }
	if opts.once then
		return vim.schedule(function()
			vim.notify_once(msg, level, nopts)
		end)
	end
	vim.schedule(function()
		vim.notify(msg, level, nopts)
	end)
end

function M.error(msg)
	M.notify(msg, "ERROR", { timeout = 1000 })
end

function M.warn(msg)
	M.notify(msg, "WARN", { timeout = 1000 })
end

function M.info(msg)
	M.notify(msg, "INFO", { timeout = 1000 })
end

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

local executed = false
function M.once(callback)
	if not executed then
		callback()
		executed = true
	end
end

return M
