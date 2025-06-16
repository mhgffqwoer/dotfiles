local M = {}

M.commit = (function()
	if vim.fn.has("nvim-0.9") == 1 then
		return "483b9a596dfd63d541db1aa51ee6ee9a1441c4cc"
	end
end)()

M.config = function()
	local builtin = require("statuscol.builtin")
	require("statuscol").setup({
		relculright = false,
		ft_ignore = { "neo-tree", "Outline", "neotest-summary" },
		segments = {
			{ text = { "%s" },                  click = "v:lua.ScSa" }, -- Sign
			{
				-- line number
				text = { " ", builtin.lnumfunc },
				condition = { true, builtin.not_empty },
				click = "v:lua.ScLa",
			},
			{ text = { " " }},
			{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- Fold
		},
	})
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			if vim.bo.filetype == "neo-tree" or vim.bo.filetype == "Outline" or vim.bo.filetype == "neotest-summary" then
				vim.opt_local.statuscolumn = ""
				vim.opt_local.signcolumn = "no"
			end
		end,
	})
end

return M