local M = {}

function M.get_arguments()
	return coroutine.create(function(dap_run_co)
	  local args = {}
	  vim.ui.input({ prompt = "Args: " }, function(input)
		args = vim.split(input or "", " ")
		coroutine.resume(dap_run_co, args)
	  end)
	end)
end

return M