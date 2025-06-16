local Logos = require("core.logos")

local M = {}

M.keys = require("core.plugins_keymap").dashboard

M.opts = function()
	local opts = {
		theme = "doom",
		hide = {
			statusline = 0,
			tabline = 0,
			winbar = 0,
		},
		config = {
			header = Logos.GetLogo("week_day"),
			center = {
				{
					icon = "󱏒  ",
					icon_hl = "DashboardSession",
					desc = "Explorer",
					key = "e",
					key_hl = "DashboardSession",
					action = function()
						require("neo-tree.command").execute({
							toggle = false,
							position = "float",
							dir = vim.loop.cwd(),
						})
					end,
				},
				{
					icon = " ",
					icon_hl = "DashboardFind",
					desc = "Find File",
					key = "f",
					key_hl = "DashboardFind",
					action = "Telescope find_files",
				},
				{
					icon = " ",
					icon_hl = "DashboardConfiguration",
					desc = "Configuration",
					key = "i",
					key_hl = "DashboardConfiguration",
					action = function()
						vim.cmd("cd ~/.config/nvim")
						vim.cmd("edit ./lua/plugins/init.lua")
					end, --"edit $MYVIMRC",
				},
				{
					icon = "󰤄  ",
					icon_hl = "DashboardLazy",
					desc = "Lazy",
					key = "l",
					key_hl = "DashboardLazy",
					action = "Lazy",
				},
				{
					icon = " ",
					icon_hl = "DashboardServer",
					desc = "Mason",
					key = "m",
					key_hl = "DashboardServer",
					action = "Mason",
				},
				{
					icon = " ",
					icon_hl = "DashboardQuit",
					desc = "Quit Neovim",
					key = "q",
					key_hl = "DashboardQuit",
					action = "qa",
				},
			},
			footer = function()
				---@diagnostic disable-next-line: different-requires
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return {
					"⚡  eovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
				}
			end,
		},
	}
	for _, button in pairs(opts.config.center) do
		button.desc = button.desc .. string.rep(" ", 45 - #button.desc)
		button.icon = button.icon .. string.rep(" ", 5 - #button.icon)
	end

	-- close Lazy and re-open when the dashboard is ready
	if vim.o.filetype == "lazy" then
		vim.cmd.close()
		vim.api.nvim_create_autocmd("User", {
			pattern = "DashboardLoaded",
			callback = function()
				---@diagnostic disable-next-line: different-requires
				require("lazy").show()
			end,
		})
	end
	return opts
end

return M
