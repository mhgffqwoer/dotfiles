local M = {}

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

return M