local config = require("plugins.editor.lualine.config.config")

local M = {}

M.setup = config.setup

function M._load()
	-- PERF: we don't need this lualine require madness 🤷
	local lualine_require = require("lualine_require")
	lualine_require.require = require

	local theme = require("plugins.editor.lualine.config.theme")(config)
	local _ = require("plugins.editor.lualine.config.palette")(config)
	local cpn = require("plugins.editor.lualine.config.components")
	-- palette.setup()

	---@diagnostic disable-next-line: undefined-field
	require("lualine").setup({
		options = {
			theme = theme,
			icons_enabled = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "dashboard", "lazy", "alpha" },
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 10,
				tabline = 1000000,
				winbar = 1000000,
			},
		},
		sections = {
			lualine_a = { cpn.branch() },
			lualine_b = { cpn.diagnostics() },
			lualine_c = {},
			lualine_x = { cpn.diff(), cpn.ai_source({ "copilot", "codeium" }) },
			lualine_y = { cpn.position(), cpn.filetype() },
			lualine_z = { cpn.spaces(), cpn.mode() },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {},
		always_divide_middle = true,
	})
end

function M.load()
	M._load()
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			M._load()
		end,
	})
end

return M
