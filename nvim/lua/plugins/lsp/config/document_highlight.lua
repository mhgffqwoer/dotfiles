local M = {}

M.words = {}
M.enabled = false
M.ns = vim.api.nvim_create_namespace("vim_lsp_references")

function M.setup(opts)
	opts = opts or {}
	if not opts.enabled then
		return
	end
	M.enabled = true
	-- local handler = vim.lsp.handlers["textDocument/documentHighlight"]
	-- vim.lsp.handlers["textDocument/documentHighlight"] = function(err, result, ctx, config)
	--   if not vim.api.nvim_buf_is_loaded(ctx.bufnr) then
	--     return
	--   end
	--   vim.lsp.buf.clear_references()
	--   return handler(err, result, ctx, config)
	-- end
	require("tools.lsp").on_support_methods("textDocument/documentHighlight", function(_, buf)
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "CursorMoved", "CursorMovedI" }, {
			buffer = buf,
			callback = function(ev)
				local cmp = package.loaded["cmp"]
				if not ({ M.words.get() })[2] then
					if ev.event:find("CursorMoved") then
						vim.lsp.buf.clear_references()
					elseif not (cmp and cmp.core.view:visible()) then
						vim.lsp.buf.document_highlight()
					end
				end
			end,
		})
	end)
end

function M.words.get()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local current, ret = nil, {}
	for _, extmark in ipairs(vim.api.nvim_buf_get_extmarks(0, M.ns, 0, -1, { details = true })) do
		local w = {
			from = { extmark[2] + 1, extmark[3] },
			to = { extmark[4].end_row + 1, extmark[4].end_col },
		}
		ret[#ret + 1] = w
		if cursor[1] >= w.from[1] and cursor[1] <= w.to[1] and cursor[2] >= w.from[2] and cursor[2] <= w.to[2] then
			current = #ret
		end
	end
	return ret, current
end

return M
