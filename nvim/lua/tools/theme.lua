local M = {}

function M.highlight(group)
	local function get_hl_by_name(name)
		local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
			or vim.api.nvim_get_hl_by_name(name, true)
		local fg = hl and (hl.fg or hl.foreground)
		local bg = hl and (hl.bg or hl.background)
		return { fg = fg, bg = bg }
	end

	local success, hl = pcall(get_hl_by_name, group)
	if not success then
		return nil  -- Если группа не существует, возвращаем nil
	end
	-- Возвращаем таблицу с цветами в формате #RRGGBB
	return {
		fg = hl.fg and string.format("#%06x", hl.fg) or nil,
		bg = hl.bg and string.format("#%06x", hl.bg) or nil,
	}
end

return M
