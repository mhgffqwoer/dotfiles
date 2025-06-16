-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	command = "set nopaste",
	pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
        vim.opt.foldenable = true
        vim.opt_local.foldenable = true
        vim.cmd("set foldenable")
  end,
})

-- vim.api.nvim_create_autocmd("BufAdd", {
--   callback = function()
--     require("bufferline")
--   end,
-- })

-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual" })
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
		"COMMIT_EDITMSG"
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = false
		vim.opt_local.spell = false
	end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = "?*",
	callback = function()
		vim.cmd([[silent! mkview 1]])
	end,
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "?*",
	callback = function()
		vim.cmd([[silent! loadview 1]])
	end,
})

-- fix comment
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd([[set formatoptions-=cro]])
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "" },
	callback = function()
		local get_project_dir = function()
			local cwd = vim.fn.getcwd()
			local project_dir = vim.split(cwd, "/")
			local project_name = project_dir[#project_dir]
			return project_name
		end

		vim.opt.titlestring = get_project_dir()
	end,
})

-- clear cmd output
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		vim.cmd([[echon '']])
	end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = { "*" },
	callback = function()
		vim.opt_local["number"] = false
		vim.opt_local["signcolumn"] = "no"
		vim.opt_local["foldcolumn"] = "0"
	end,
})

-- fix comment on new line
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd([[set formatoptions-=cro]])
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- auto commit
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "COMMIT_EDITMSG",
	callback = function()
		local git_root = vim.fn.system('git rev-parse --show-toplevel')
		git_root = git_root:gsub("\n", "")
		local commit_msg_file = git_root .. "/.git/COMMIT_EDITMSG"
		local commit_command = 'git commit --file="' .. commit_msg_file .. '" --cleanup=strip'
		local result = vim.fn.system(commit_command)
		vim.fn.system('rm ' .. commit_msg_file)
		print(result)
	end
})

-- close buffer some filetypes with <leader>q
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"gitcommit",
		"gitgraph",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "<leader>q", function()
			require("bufdelete").bufdelete(0, true)
		end, { buffer = event.buf, desc = "Close" })
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = {
-- 		"neotest-summary",
-- 	},
-- 	callback = function(event)
-- 		vim.bo[event.buf].buflisted = false
-- 		vim.keymap.set("n", "<leader>q", function()
-- 			require("bufdelete").bufdelete(0, false)
-- 			vim.cmd("q!")
-- 		end, { buffer = event.buf, desc = "Close" })
-- 	end,
-- })

-- set cursor on some filetypes
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "neotest-summary" then
			require("neotest").summary.close()
			vim.cmd([[
				setlocal guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
				hi Cursor blend=0
  			]])
		end
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "neotest-summary",
	callback = function(event)
		vim.keymap.set("n", "<leader>q", function()
			require("neotest").summary.close()
		end, { buffer = event.buf, desc = "Close" })
	end,
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*", -- Укажите имя буфера Lazy (например, "lazy")
	callback = function()
		if vim.bo.filetype == "lazy" then
			vim.cmd("q")
		end
	end,
})
-- -- Автокоманда для изменения цвета выделения в визуальном режиме
vim.api.nvim_create_augroup("VisualHighlight", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
	group = "VisualHighlight",
	pattern = "*:[vV\x16]", -- переход в визуальный режим
	callback = function()
		vim.cmd("highlight Visual guibg=#e0af68 guifg=#000000")
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	group = "VisualHighlight",
	pattern = "[vV\x16]:*",                                -- выход из визуального режима
	callback = function()
		vim.cmd("highlight Visual guibg=#44475a ctermbg=gray") -- стандартный цвет, или свой
	end,
})
