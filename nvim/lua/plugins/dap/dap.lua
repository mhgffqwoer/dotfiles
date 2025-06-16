local M = {}

M.keys = {
	{
		"bb",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Breakpoint",
	},
	{
		"bc",
		function()
			require("dap").continue()
		end,
		desc = "Run/Continue ",
	},
	{
		"bi",
		function()
			require("dap").step_into()
		end,
		desc = "",
	},
	{
		"bl",
		function()
			require("dap").run_last()
		end,
		desc = "",
	},
	{
		"bO",
		function()
			require("dap").step_out()
		end,
		desc = "",
	},
	{
		"bo",
		function()
			require("dap").step_over()
		end,
		desc = "",
	},
	{
		"bP",
		function()
			require("dap").pause()
		end,
		desc = "",
	},
	{
		"bt",
		function()
			require("dap").terminate()
		end,
		desc = "",
	},
	{
		"bw",
		function()
			require("dap.ui.widgets").preview()
		end,
		desc = "hover", 
	},
	{
		"bW",
		function()
			require("dap").evaluate(vim.fn.expand("<cword>"), {
				context = "hover",
				callback = function(res)
				  if res and res.result then
					print(res.result)  -- Выводим результат в командной строке
					-- vim.notify(res.result)  -- Или используем уведомление, если нужно
				  else
					print("Не удалось получить значение переменной")
				  end
				end
			  })
		end,
		desc = "hover",
	}
}

M.config = function()
	-- load mason-nvim-dap here, after all adapters have been setup
	if require("tools.plugin").has("mason-nvim-dap.nvim") then
		require("mason-nvim-dap").setup(require("tools.plugin").opts("mason-nvim-dap.nvim"))
	end

	vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

	vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "->", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
end

return M
