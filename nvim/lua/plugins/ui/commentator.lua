local M = {}

M.opts = {
	padding = true,
	sticky = true,
	ignore = nil,
	toggler = {
		line = "<leader>/",
		block = "gg",
	},
	opleader = {
		line = "<leader>/",
		block = "gg",
	},
	mappings = {
		basic = true,
		extra = false,
	},
	pre_hook = nil,
	post_hook = nil,
}

return M

