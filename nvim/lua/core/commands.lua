local create_command = vim.api.nvim_create_user_command

create_command('CreateCommitMessage', function()
	local git_root = vim.fn.system('git rev-parse --show-toplevel 2>&1')

	-- Проверяем, есть ли в выводе ошибка (например, "fatal:")
	if git_root:match("fatal:") then
		vim.cmd.echo('"Ошибка: текущая директория не является Git-репозиторием"')
		return
	else
		-- Убираем символ новой строки и выводим результат
		git_root = git_root:gsub("\n", "")
		vim.cmd.echo('"Git-репозиторий найден: ' .. git_root .. '"')
	end

	local commit_msg_file = git_root .. "/.git/COMMIT_EDITMSG"

	local commit_text = vim.fn.system('git commit --dry-run')

	-- Создаём файл .git/COMMIT_EDITMSG с сообщением
	local file = io.open(commit_msg_file, "w")
	if file then
		for line in commit_text:gmatch("[^\r\n]+") do
			file:write("# " .. line .. "\n") -- Добавляем # в начале каждой строки
		end
		file:write("#")
		file:close()
	else
		print("Не удалось создать файл: " .. commit_msg_file)
	end

	-- Даем файлу правильные права
	os.execute("chmod u=rw,g=r,o=r " .. commit_msg_file)

	-- Открываем файл в правом вертикальном сплите
	vim.cmd("edit " .. commit_msg_file)
	--vim.cmd("setlocal nobuflisted")
end, {})

vim.api.nvim_create_user_command("GitAdd", function()
	local file = vim.fn.expand("%") -- Получаем путь к текущему файлу
	local cmd = "git add " .. file -- Формируем команду git add
	local result = vim.fn.system(cmd) -- Выполняем команду

	if vim.v.shell_error ~= 0 then -- Проверяем, была ли ошибка
		vim.notify("Ошибка: " .. result, vim.log.levels.ERROR)
	else
		vim.notify("Файл добавлен: " .. file, vim.log.levels.INFO)
	end
end, {})

-- Вызов меню выбора с Dressing.nvim
vim.api.nvim_create_user_command("TestDressing1", function()
	vim.ui.input(
		{ prompt = "Введи текст:" },
		function(text)
			print("Текст: " .. (text or "ничего"))
		end
	)
end, {})

vim.api.nvim_create_user_command("TestDressing2", function()
	local text = vim.fn.input("Введи текст:")
	print("Текст: " .. (text or "ничего"))
end, {})

vim.api.nvim_create_user_command("TestDressing3", function()
	vim.ui.select(
		{ "Option 1", "Option 2", "Option 3" }, -- Список вариантов
		{ prompt = "Выбери что-то:" }, -- Заголовок меню
		function(choice) -- Обработчик выбора
			if choice then
				print("Выбрано: " .. choice)
			else
				print("Отменено!")
			end
		end
	)
end, {})