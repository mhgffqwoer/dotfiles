local M = {}

M.keys = {
	{
		"bu",
		function()
			require("dapui").toggle({})
		end,
		desc = "Dap UI",
	},
	{
		"be",
		function()
			require("dapui").eval()
		end,
		desc = "Eval",
		mode = { "n", "v" },
	},
}

M.opts = {
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 1,
				},
				-- {
				-- 	id = "breakpoints",
				-- 	size = 0.25,
				-- },
				-- {
				-- 	id = "stacks",
				-- 	size = 0.25,
				-- },
				-- {
				-- 	id = "watches",
				-- 	size = 0.25,
				-- },
			},
			position = "right",
			size = 40,
		},
		{
			elements = {
				{
					id = "console",
					size = 1,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
}

M.config = function(_, opts)
	-- local dap = require("dap")
	local dapui = require("dapui")
	dapui.setup(opts)
	-- dap.listeners.after.event_initialized["dapui_config"] = function()
	-- 	dapui.open({})
	-- end
	-- dap.listeners.before.event_terminated["dapui_config"] = function()
	-- 	dapui.close({})
	-- end
	-- dap.listeners.before.event_exited["dapui_config"] = function()
	-- 	dapui.close({})
	-- end
end

return M