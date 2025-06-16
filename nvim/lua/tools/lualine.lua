local M = {}

local highlight_context = {}
local component_context = {}
local counter = 0

function M.get_hl_gr(key)
	if highlight_context[key] ~= nil then
		return highlight_context[key]
	end
	local hl_gr = ("SL" .. counter):gsub("%s+", "")
	highlight_context[key] = hl_gr
	counter = counter + 1
	return hl_gr
end

function M.hl_str(text, hl_cur, hl_after)
	if hl_after == nil then
		return "%#" .. hl_cur .. "#" .. text .. "%*"
	end
	return "%#" .. hl_cur .. "#" .. text .. "%*" .. "%#" .. hl_after .. "#"
end

function M.truncate(text, min_width)
	if string.len(text) > min_width then
		return string.sub(text, 1, min_width) .. "…"
	end
	return text
end

function M.get_component_bg(type)
	local bg = "#555555"
	if type == "fill" then
		bg = require("tools.theme").highlight("Pmenu").bg or bg
	elseif type == "thin" then
		bg = require("tools.theme").highlight("lualine_c_normal").bg or bg
	end
	return bg
end

function M.build_component(config, texts, type, bg, text_sep, cache_key)
	if cache_key ~= nil and component_context[cache_key] ~= nil then
		return component_context[cache_key]
	end

	local BAR_BG = require("tools.theme").highlight("lualine_c_normal").bg
	local SEP_GROUP = "SLSeparator"
	bg = bg or M.get_component_bg(type)

	if type == "fill" then
		vim.api.nvim_set_hl(0, SEP_GROUP, { fg = bg, bg = BAR_BG })
	elseif type == "thin" then
		vim.api.nvim_set_hl(0, SEP_GROUP, { fg = require("tools.theme").highlight("Pmenu").bg, bg = BAR_BG })
	end

	local merged_text = table.concat(
		vim.tbl_map(function(text)
			local hl_gr = M.get_hl_gr(text.text)
			if config.float then
				if type == "fill" then
					vim.api.nvim_set_hl(0, hl_gr, { fg = text.color, bg = bg })
				else
					vim.api.nvim_set_hl(0, hl_gr, { fg = text.color, bg = BAR_BG })
				end
			else
				vim.api.nvim_set_hl(0, hl_gr, { fg = text.color, bg = BAR_BG })
			end
			return M.hl_str(text.text, hl_gr, hl_gr)
		end, texts),
		text_sep or ""
	)

	local final
	if config.float then
		final = M.hl_str(config.separator[type].left, SEP_GROUP)
			.. merged_text
			.. M.hl_str(config.separator[type].right, SEP_GROUP, SEP_GROUP)
	else
		final = merged_text
	end

	if cache_key ~= nil then
		component_context[cache_key] = final
	end
	return final
end

function M.hide_width(width)
	width = width or 85
	return vim.fn.winwidth(0) > width
end

return M
