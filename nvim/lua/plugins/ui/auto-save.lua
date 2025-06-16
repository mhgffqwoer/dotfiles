local M = {}

M.config = function()
	require("auto-save").setup({
		execution_message = {
			message = function () return "" end
		}
	})
end

return M
