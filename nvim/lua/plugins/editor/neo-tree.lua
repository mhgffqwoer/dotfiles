local Icons = require("core.icons")

local function hideCursor()
	if vim.g.smear_cursor == true then
		require("smear_cursor").toggle()
		vim.g.smear_cursor = false
	end

	vim.cmd([[
    setlocal guicursor=n:block-Cursor
    setlocal foldcolumn=0
    hi Cursor blend=100
  ]])
end
local function showCursor()
	if vim.g.smear_cursor == false then
		require("smear_cursor").toggle()
		vim.g.smear_cursor = true
	end

	vim.cmd([[
    setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
    hi Cursor blend=0
  ]])
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertEnter" }, {
	callback = function()
		local action = (vim.bo.filetype == "neo-tree" or vim.bo.filetype == "Outline") and hideCursor or showCursor
		action()
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
	callback = function()
		showCursor()
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "neo-tree",
-- 	callback = function()
-- 	  vim.notify = function() end
-- 	end,
--   })

local M = {}

M.keys = require("core.plugins_keymap").neo_tree.main

M.init = function()
	vim.g.neo_tree_remove_legacy_commands = 1
	if vim.fn.argc() == 1 then
		local stat = vim.uv.fs_stat(vim.fn.argv(0))
		if stat and stat.type == "directory" then
			require("neo-tree")
			vim.cmd([[set showtabline=0]])
		end
	end
end

M.deactivate = function()
	vim.cmd([[Neotree close]])
end

M.opts = {
	close_if_last_window = true,
	popup_border_style = require("tools.ui").borderchars("thick", "tl-t-tr-r-br-b-bl-l"),
	sources = {
		"filesystem",
		--"buffers",
		--"git_status",
		-- "diagnostics",
		"document_symbols",
	},
	source_selector = {
		winbar = false,
		content_layout = "center",
		tabs_layout = "equal",
		show_separator_on_edge = true,
		sources = {
			{ source = "filesystem", display_name = "󰉓" },
			{ source = "buffers", display_name = "󰈙" },
			{ source = "git_status", display_name = "" },
			-- { source = "document_symbols", display_name = "󰈙" },
			-- { source = "diagnostics", display_name = "󰒡" },
		},
	},
	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 1,
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			enabled = true,
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			folder_empty_open = "",
			default = " ",
		},
		modified = { symbol = "●" },
		git_status = { symbols = Icons.git },
		diagnostics = { symbols = Icons.diagnostics },
	},
	window = {
		width = 35,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = require("core.plugins_keymap").neo_tree.window_mappings,
	},
	filesystem = {
		window = {
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = require("core.plugins_keymap").neo_tree.filesystem_mappings,
		},
		filtered_items = {
			hide_dotfiles = true,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true,
		},
		group_empty_dirs = false,
		use_libuv_file_watcher = true,
		components = {
			name = function(config, node, state)
				local common = require("neo-tree.sources.common.components")
				local highlights = require("neo-tree.ui.highlights")

				local highlight = config.highlight or highlights.FILE_NAME
				local text = node.name
				if node.type == "directory" then
					highlight = highlights.DIRECTORY_NAME
					if config.trailing_slash and text ~= "/" then
						text = text .. "/"
					end
				end

				if node:get_depth() == 1 and node.type ~= "message" then
					highlight = highlights.ROOT_NAME
					text = vim.fn.fnamemodify(text, ":p:h:t")
					text = string.upper(text)
				else
					local filtered_by = common.filtered_by(config, node, state)
					highlight = filtered_by.highlight or highlight
					if config.use_git_status_colors then
						local git_status = state.components.git_status({}, node, state)
						if git_status and git_status.highlight then
							highlight = git_status.highlight
						end
					end
				end

				if type(config.right_padding) == "number" then
					if config.right_padding > 0 then
						text = text .. string.rep(" ", config.right_padding)
					end
				else
					text = text .. " "
				end

				return {
					text = text,
					highlight = highlight,
				}
			end,
			icon = function(config, node, state)
				local common = require("neo-tree.sources.common.components")
				local highlights = require("neo-tree.ui.highlights")

				local icon = config.default or " "
				local highlight = config.highlight or highlights.FILE_ICON
				if node.type == "directory" then
					highlight = highlights.DIRECTORY_ICON
					if node.loaded and not node:has_children() then
						icon = not node.empty_expanded and config.folder_empty or config.folder_empty_open
					elseif node:is_expanded() then
						icon = config.folder_open or "-"
					else
						icon = config.folder_closed or "+"
					end
				elseif node.type == "file" or node.type == "terminal" then
					local success, web_devicons = pcall(require, "nvim-web-devicons")
					if success then
						local devicon, hl = web_devicons.get_icon(node.name, node.ext)
						icon = devicon or icon
						highlight = hl or highlight
					end
				end

				local filtered_by = common.filtered_by(config, node, state)

				-- Don't render icon in root folder
				if node:get_depth() == 1 then
					return {
						text = nil,
						highlight = highlight,
					}
				end

				return {
					text = icon .. " ",
					highlight = filtered_by.highlight or highlight,
				}
			end,
		},
	},
	async_directory_scan = "always",
}

return M
