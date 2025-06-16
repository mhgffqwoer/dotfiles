local Icons = require("core.icons")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"--branch=stable", "https://github.com/folke/lazy.nvim.git",
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
		version = false,
		cond = nil,
	},
	git = {
		log = { "-8" },
		timeout = 120,
		filter = true,
	},

	install = {
		missing = true,            -- устанавливать недостающие плагины при старте
		colorscheme = { "monokai-pro" }, -- попытаться загрузить одну из этих тем при установке
	},

	ui = {
		size = { width = 0.8, height = 0.8 }, -- размер интерфейса Lazy
		wrap = true,                    -- перенос строк в UI
		border = "none",                -- граница окна интерфейса Lazy
		backdrop = 60,                  -- прозрачность фона (0 — непрозрачный, 100 — полностью прозрачный)
		title = nil,                    -- заголовок окна (только если border не "none")
		title_pos = "center",           -- позиция заголовка ("center" | "left" | "right")
		pills = true,                   -- отображать "пилюли" на верхней панели Lazy
		throttle = 1000 / 30,           -- частота обновления интерфейса
		icons = {
			ft = Icons.lazy.ft,
			lazy = Icons.lazy.lazy,
			loaded = Icons.lazy.loaded,
			not_loaded = Icons.lazy.not_loaded,
		},
		custom_keys = {
			["<localleader>l"] = false,
			["<localleader>i"] = false,
			["<localleader>t"] = false,
		},
	},

	headless = {
		process = false, -- показывать вывод процессов (git и т.п.)
		log = false, -- показывать логи
		task = false, -- показывать старт/завершение задач
		colors = false, -- использовать ANSI цвета
	},

	diff = {
		cmd = "git", -- команда для сравнения изменений (можно заменить на diffview.nvim и др.)
	},

	checker = {
		enabled = false, -- автоматически проверять обновления плагинов
		frequency = 3600, -- проверять обновления раз в час
		notify = false, -- уведомление при обнаружении обновлений
	},

	change_detection = {
		enabled = false, -- автоматически проверять изменения в конфиге и перезагружать UI
		notify = false, -- уведомление при обнаружении изменений
	},

	performance = {
		cache = { enabled = true },
		reset_packpath = true, -- сбросить package path для ускорения старта
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"matchit",
				"matchparen",
				"ftplugin",
			},
		},
	},

	readme = {
		enabled = true,
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md", "lua/**/README.md" },
		skip_if_doc_exists = true, -- генерировать helptags только если нет официальных документов
	},

	state = vim.fn.stdpath("state") .. "/lazy/state.json", -- состояние плагинов (для checker и прочего)
	profiling = {
		loader = false,                                 -- включить статистику по загрузке плагинов
		require = false,                                -- отслеживать каждый новый require в профайлере Lazy
	},

	pkg = {
		enabled = true,
		cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
		-- the first package source that is found for a plugin will be used.
		sources = {
			"lazy",
			"rockspec", -- will only be used when rocks.enabled is true
			"packspec",
		},
	},
	rocks = {
		enabled = false,
		root = vim.fn.stdpath("data") .. "/lazy-rocks",
		server = "https://nvim-neorocks.github.io/rocks-binaries/",
		-- use hererocks to install luarocks?
		-- set to `nil` to use hererocks when luarocks is not found
		-- set to `true` to always use hererocks
		-- set to `false` to always use luarocks
		hererocks = nil,
	},
})
