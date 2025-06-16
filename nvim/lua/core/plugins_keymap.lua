local keys = {}

keys.monokai_pro = {
	{ "<leader>C", "<cmd>MonokaiProSelect<cr>", desc = "[Colorscheme] Select" },
}

keys.neo_tree = {
	main = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({
					toggle = false,
					position = "left",
					dir = vim.loop.cwd(),
				})
			end,
			desc = "[Neo-Tree] Explorer",
			remap = true,
		},
		{
			"<leader>E",
			function()
				require("neo-tree.command").execute({
					toggle = false,
					position = "float",
					dir = vim.loop.cwd(),
				})
			end,
			desc = "[Neo-Tree] Explorer Float",
		},
	},
	window_mappings = {
		["P"] = { "toggle_preview", config = { use_float = false }, desc = "[Neo-Tree] Preview (on/off)" },
		["q"] = { "close_window", desc = "[Neo-Tree] Close" },
		["<esc>"] = { "close_window", desc = "[Neo-Tree] Close" },
		["H"] = "none",
		["<space>"] = "none",
	},
	filesystem_mappings = {
		["<2-LeftMouse>"] = { "open", desc = "[Neo-Tree] Open" },
		["<cr>"] = { "open", desc = "[Neo-Tree] Open" },
		[","] = { "navigate_up", desc = "[Neo-Tree] Navigate up" },
		["<bs>"] = { "toggle_hidden", desc = "[Neo-Tree] Hidden (on/off)" },
		["."] = { "set_root", desc = "[Neo-Tree] Set root" },
		["?"] = { "show_help", desc = "[Neo-Tree] Help" },
		["a"] = { "add", config = { show_path = "relative" }, desc = "[Neo-Tree] New File" }, -- "none", "relative", "absolute"
		["A"] = { "add_directory", desc = "[Neo-Tree] New Directory" },
		["i"] = { "show_file_details", desc = "[Neo-Tree] Info" },
		["/"] = { "open_vsplit", desc = "[Neo-Tree] Split window vertically" },
		["z"] = { "close_all_nodes", desc = "[Neo-Tree] Close all nodes" },
		["c"] = { "copy_to_clipboard", desc = "[Neo-Tree] Copy" },
		["m"] = { "cut_to_clipboard", desc = "[Neo-Tree] Move" },
		["p"] = { "paste_from_clipboard", desc = "[Neo-Tree] Paste" },
		["d"] = { "delete", desc = "[Neo-Tree] Delete" },
		["r"] = { "rename", desc = "[Neo-Tree] Rename" },
		["R"] = { "refresh", desc = "[Neo-Tree] Refresh" },
		["o"] = { "show_help", desc = "[Neo-Tree] OrderBy" },
		["oc"] = { "order_by_created", desc = "[Neo-Tree] Sort by created date" },
		["od"] = { "order_by_diagnostics", desc = "[Neo-Tree] Sort by diagnostic severity" },
		["og"] = { "order_by_git_status", desc = "[Neo-Tree] Sort by git status" },
		["om"] = { "order_by_modified", desc = "[Neo-Tree] Sort by last modified date" },
		["on"] = { "order_by_name", desc = "[Neo-Tree] Sort by name" },
		["os"] = { "order_by_size", desc = "[Neo-Tree] Sort by size" },
		["ot"] = { "order_by_type", desc = "[Neo-Tree] Sort by type" },
		["gA"] = {"git_add_all", desc = "[Neo-Tree] Git Add All"},
      	["ga"] = {"git_add_file", desc = "[Neo-Tree] Git Add File"},
      	["gu"] = {"git_unstage_file", desc = "[Neo-Tree] Git Unstage File"},
      	["gr"] = {"git_revert_file", desc = "[Neo-Tree] Git Revert File"},
		["f"] = "none",
		["S"] = "none",
		["s"] = "none",
		["t"] = "none",
		["w"] = "none",
		["l"] = "none",
		["x"] = "none",
		["y"] = "none",
		["b"] = "none",
		["#"] = "none",
		["e"] = "none",
		["<c-b>"] = "none",
		["<c-f>"] = "none",
		["<c-x>"] = "none",
		["D"] = "none",
		["C"] = "none",
		["[g"] = "none",
		["]g"] = "none",
		["<"] = "none",
		[">"] = "none",
	},
}

keys.dashboard = {
	{
		"<leader>0",
		function()
		  -- Закрыть Neo-tree, если открыт
		  local ok, neo_tree = pcall(require, "neo-tree.command")
		  if ok then
			neo_tree.execute({ action = "close" })
		  end
	  
		  -- Закрыть все буферы, кроме одного (опционально)
		  vim.cmd("bufdo bd")  -- закрывает все буферы
	  
		  -- Закрыть все плагины оконные (типа Trouble, symbols-outline и прочее), если юзаешь
	  
		  -- Перекинуть в начальную директорию
		  vim.cmd("cd " .. vim.g.initial_cwd)
	  
		  -- Открыть Dashboard
		  vim.cmd("Dashboard")
		end,
		desc = "[Dashboard] Home page",
	  }	  
}

keys.buffer_line = {
	{ ">", "<Cmd>BufferLineCycleNext<CR>", desc = "[Buffer] Next" },
	{ "<", "<Cmd>BufferLineCyclePrev<CR>", desc = "[Buffer] Previous" },
}

keys.conform = {
	{
		"<leader>w",
		function()
			local cf = require("conform")
			cf.format({ async = false, lsp_fallback = true })
		end,
		desc = "[Format]",
	},
}

keys.notify = {
	{
		"<leader>n",
		function()
			require("notify").dismiss({ silent = true, pending = true })
		end,
		desc = "Clear all notifications",
	},
}

keys.telescope = {
	-- Поиск
	--   { "sc",         "<cmd>Telescope colorscheme<cr>",  desc = "Search Colorscheme" },
	--   { "sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help" },
	--   { "sr", "<cmd>Telescope oldfiles<cr>", desc = "Search Recent File" },
	--   { "sk", "<cmd>Telescope keymaps<cr>", desc = "Search Keymaps" },
	--   { "sC", "<cmd>Telescope commands<cr>", desc = "Search Commands" },
	--   { "sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
	-- Git
	--{ "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
	{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
	--{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Checkout" },
	--{ "<leader>gt", "<cmd>Telescope git_tags<cr>", desc = "Git Tags" },
	-- Файлы
	{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
	{ "<leader>F", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
	--   { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
}

keys.folds = {
	{ "fd", "zd", desc = "Delete fold under cursor" },
	{ "fo", "zo", desc = "Open fold under cursor" },
	{ "fO", "zO", desc = "Open all folds under cursor" },
	{ "fc", "zC", desc = "Close all folds under cursor" },
	{ "fa", "za", desc = "Toggle fold under cursor" },
	{ "fA", "zA", desc = "Toggle all folds under cursor" },
	{ "fv", "zv", desc = "Show cursor line" },
	{
		"fM",
		function()
			require("ufo").closeAllFolds()
		end,
		desc = "Close all folds",
	},
	{
		"fR",
		function()
			require("ufo").openAllFolds()
		end,
		desc = "Open all folds",
	},
	{
		"fm",
		function()
			require("ufo").closeFoldsWith()
		end,
		desc = "Fold more",
	},
	{
		"fr",
		function()
			require("ufo").openFoldsExceptKinds()
		end,
		desc = "Fold less",
	},
	{ "fx", "zx", desc = "Update folds" },
	{ "fz", "zz", desc = "Center this line" },
	{ "ft", "zt", desc = "Top this line" },
	{ "fb", "zb", desc = "Bottom this line" },
	{ "fg", "zg", desc = "Add word to spell list" },
	{ "fw", "zw", desc = "Mark word as bad/misspelling" },
	{ "fe", "ze", desc = "Right this line" },
	{ "fE", "zE", desc = "Delete all folds in current buffer" },
	{ "fs", "zs", desc = "Left this line" },
	{ "fH", "zH", desc = "Half screen to the left" },
	{ "fL", "zL", desc = "Half screen to the right" },
}

keys.windows = {
	{ "<leader>z", "<cmd>WindowsMaximize<CR>", desc = "Zoom window" },
}

keys.hover = function()
	vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
	vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
	vim.keymap.set("n", "<C-p>", function()
		require("hover").hover_switch("previous")
	end, { desc = "hover.nvim (previous source)" })
	vim.keymap.set("n", "<C-n>", function()
		require("hover").hover_switch("next")
	end, { desc = "hover.nvim (next source)" })
	vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
	vim.o.mousemoveevent = true
end

keys.symbols_outline = {
	{ "<leader>o", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
}

keys.testing = {
	{ "<leader>t", "", desc = "+test" },
	{
		"<leader>tt",
		function()
			require("neotest").run.run(vim.fn.expand("%"))
		end,
		desc = "Run File (Neotest)",
	},
	{
		"<leader>tT",
		function()
			require("neotest").run.run(vim.uv.cwd())
		end,
		desc = "Run All Test Files (Neotest)",
	},
	{
		"<leader>ts",
		function()
			require("neotest").summary.toggle()
			vim.defer_fn(function()
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.bo[buf].filetype == "neotest-summary" then
						local winid = vim.fn.bufwinid(buf)
						if winid ~= -1 then -- Если окно существует
							vim.api.nvim_set_current_win(winid) -- Перемещаем курсор в это окно
							vim.cmd([[
									setlocal guicursor=n:block-Cursor
									setlocal foldcolumn=0
									hi Cursor blend=100
								]])
							return
						end
					end
				end
			end, 50)
		end,
		desc = "Open Summary (Neotest)",
	},
	{
		"<leader>to",
		function()
			require("neotest").output_panel.toggle()
		end,
		desc = "Toggle Output Panel (Neotest)",
	},
	{
		"<leader>tS",
		function()
			require("neotest").run.stop()
		end,
		desc = "Stop (Neotest)",
	},
}

return keys
