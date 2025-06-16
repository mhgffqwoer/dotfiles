local M = {}

function M.surround_visual(open, close)
	return function()
		vim.cmd("normal! \27") 

		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")

		local c = vim.api.nvim_buf_get_text(0, start_pos[2]-1, start_pos[3]-1, end_pos[2]-1, end_pos[3]-1, {})
		c[1] = open .. c[1]
		c[#c] = c[#c] .. close
		vim.api.nvim_buf_set_text(0, start_pos[2]-1, start_pos[3]-1, end_pos[2]-1, end_pos[3]-1, c)

		if #c == 1 then
			vim.fn.setpos("'<", {0, start_pos[2], start_pos[3]+1, 0})
			vim.fn.setpos("'>", {0, end_pos[2], end_pos[3]+1, 0})
		else 
			vim.fn.setpos("'<", {0, start_pos[2], start_pos[3]+1, 0})
			vim.fn.setpos("'>", {0, end_pos[2], end_pos[3], 0})
		end

		print("Surrounding with " .. open .. " and " .. close)

		vim.cmd("normal! gv")
	end
end

return M