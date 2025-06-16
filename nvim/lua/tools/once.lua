local M = {}

local executed = false

function M.once(callback)
	if not executed then
		callback()
		executed = true
	end
end

return M