local M = {}

function M.has(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

function M.opts(name)
	local plugin = require("lazy.core.config").plugins[name]
	if not plugin then
		return {}
	end
	local Plugin = require("lazy.core.plugin")
	return Plugin.values(plugin, "opts", false)
end

return M
