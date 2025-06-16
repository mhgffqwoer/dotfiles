local M = {}

local function hideCursor()
	if vim.g.smear_cursor == true then
		require("smear_cursor").toggle()
		vim.g.smear_cursor = false
	end
end

local function showCursor()
	if vim.g.smear_cursor == false then
		require("smear_cursor").toggle()
		vim.g.smear_cursor = true
	end
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertEnter", "FileType" }, {
	pattern = "neotest-summary",
	callback = function()
		print("neotest-summary-open")
		if vim.bo.filetype == "neotest-summary" then
			showCursor()
		end
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
	pattern = "neotest-summary",
	callback = function()
		print("neotest-summary-close")
		hideCursor()
	end,
})

M.opts = {
	adapters = {
		["neotest-golang"] = {
			go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
			dap_go_enabled = true,
		},
		-- ["neotest-dotnet"] = {  -- work only if this adapter is only one
		-- 	discovery_root = "project"
		-- },
	},
	status = { virtual_text = false },
	output = { open_on_run = false },
}

M.config = function(_, opts)
	local neotest_ns = vim.api.nvim_create_namespace("neotest")
	vim.diagnostic.config({
		virtual_text = {
			format = function(diagnostic)
				-- Replace newline and tab characters with space for more compact diagnostics
				local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
				return message
			end,
		},
	}, neotest_ns)

	if opts.adapters then
		local adapters = {}
		for name, config in pairs(opts.adapters or {}) do
			if type(name) == "number" then
				if type(config) == "string" then
					config = require(config)
				end
				adapters[#adapters + 1] = config
			elseif config ~= false then
				local adapter = require(name)
				if type(config) == "table" and not vim.tbl_isempty(config) then
					local meta = getmetatable(adapter)
					if adapter.setup then
						adapter.setup(config)
					elseif adapter.adapter then
						adapter.adapter(config)
						adapter = adapter.adapter
					elseif meta and meta.__call then
						adapter = adapter(config)
					else
						error("Adapter " .. name .. " does not support setup")
					end
				end
				adapters[#adapters + 1] = adapter
			end
		end
		opts.adapters = adapters
	end

	require("neotest").setup(opts)
end

M.keys = require("core.plugins_keymap").testing

return M

