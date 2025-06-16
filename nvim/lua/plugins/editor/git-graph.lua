local Icons = require("core.icons")

local M = {}

M.opts = {
	symbols = {
		merge_commit = "",
		commit = "",
		merge_commit_end = "",
		commit_end = "",

		-- Advanced symbols
		GVER = "",
		GHOR = "",
		GCLD = "",
		GCRD = "╭",
		GCLU = "",
		GCRU = "",
		GLRU = "",
		GLRD = "",
		GLUD = "",
		GRUD = "",
		GFORKU = "",
		GFORKD = "",
		GRUDCD = "",
		GRUDCU = "",
		GLUDCD = "",
		GLUDCU = "",
		GLRDCL = "",
		GLRDCR = "",
		GLRUCL = "",
		GLRUCR = "",
	},
	format = {
		timestamp = "%H:%M:%S %d-%m-%Y",
		fields = { "hash", "timestamp", "author", "branch_name", "tag", "message" },
	},
	hooks = {
		on_select_commit = function(commit)
			-- Формируем команду для выполнения
			local cmd = "git checkout " .. commit.hash

			-- Выполняем команду через vim.fn.system
			local result = vim.fn.system(cmd)

			-- Проверяем, была ли ошибка
			if vim.v.shell_error ~= 0 then
				vim.notify("Ошибка: " .. result, vim.log.levels.ERROR)
			else
				vim.notify("Переключено на коммит: " .. commit.hash, vim.log.levels.INFO)
			end

			-- Выводим хэш коммита в консоль
			print("Выбран коммит:", commit.hash)
		end,
	},
}

M.keys = {
	{
		"<leader>gc",
		function()
			vim.cmd("CreateCommitMessage")
		end,
		desc = "[Git] Create Commit",
	},
	{
		"<leader>gl",
		function()
			local git_root = vim.fn.system("git rev-parse --show-toplevel 2>&1")
			if git_root:match("fatal:") then
				vim.cmd.echo(
					'"Ошибка: текущая директория не является Git-репозиторием"'
				)
				return
			else
				require("gitgraph").draw({}, { all = true, max_count = 5000 })
			end
		end,
		desc = "[Git] Drow graph",
	},
}

return M

