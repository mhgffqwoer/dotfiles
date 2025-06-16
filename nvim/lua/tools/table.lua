local M = {}

function M.any(collection, predicate)
	for _, value in ipairs(collection) do
		if predicate(value) then
			return true
		end
	end
	return false
end

return M
