local M = {}

M.opts_extend = { "ensure_installed" }

M.opts = {
	ensure_installed = {
		"stylua",
		"luacheck",
	},
	ui = {
		icons = {
			package_pending = Icons.mason.pending,
			package_installed = Icons.mason.installed,
			package_uninstalled = Icons.mason.uninstalled,
		},
	},
}

M.config = function(_, opts)
	require("mason").setup(opts)
	local mr = require("mason-registry")
	local function ensure_installed()
		for _, tool in ipairs(opts.ensure_installed) do
			local p = mr.get_package(tool)
			if not p:is_installed() then
				p:install()
			end
		end
	end
	if mr.refresh then
		mr.refresh(ensure_installed)
	else
		ensure_installed()
	end
end

return M