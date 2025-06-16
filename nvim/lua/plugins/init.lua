return {

	---@Core
	{
		url = "https://github.com/folke/lazy.nvim",
		version = "*",
	},

	---@Languages
	{ import = "plugins.Languages.go" },
	{ import = "plugins.Languages.python" },
	-- { import = "plugins.Languages.java"},

	---@Colorscheme
	{
		name = "monokai-pro",
		enabled = true,
		event = { "VimEnter" },
		url = "https://github.com/loctvl842/monokai-pro.nvim",
		lazy = false,
		priority = 1000,
		keys = require("plugins.colorscheme.monokai_pro").keys,
		opts = require("plugins.colorscheme.monokai_pro").opts,
		config = require("plugins.colorscheme.monokai_pro").config,
	},

	---@Coding
	{
		name = "cmp",
		enabled = true,
		url = "https://github.com/hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			{ name = "jdtls", url = "https://github.com/mfussenegger/nvim-jdtls" },
			{ name = "cmp-nvim-lsp", url = "https://github.com/hrsh7th/cmp-nvim-lsp" },
			{ name = "cmp-buffer", url = "https://github.com/hrsh7th/cmp-buffer" },
			{ name = "cmp-path", url = "https://github.com/hrsh7th/cmp-path" },
			{ name = "cmp-cmdline", url = "https://github.com/hrsh7th/cmp-cmdline" },
			{ name = "cmp_luasnip", url = "https://github.com/saadparwaiz1/cmp_luasnip" },
		},
		opts = require("plugins.coding.cmp").opts,
		config = require("plugins.coding.cmp").config,
	},

	{
		name = "luasnip",
		enabled = true,
		url = "https://github.com/L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = {
			{
				name = "friendly-snippets",
				url = "https://github.com/rafamadriz/friendly-snippets",
				config = require("plugins.coding.luasnip").friendly_snippets_config,
			},
		},
		config = require("plugins.coding.luasnip").config,
	},

	---@LSP
	{
		name = "mason",
		enabled = true,
		url = "https://github.com/williamboman/mason.nvim",
		lazy = false,
		--event = { "VimEnter" },
		cmd = "Mason",
		build = ":MasonUpdate",
		opts_extend = require("plugins.lsp.mason").opts_extend,
		opts = require("plugins.lsp.mason").opts,
		config = require("plugins.lsp.mason").config,
	},

	{
		name = "lspconfig",
		enabled = true,
		url = "https://github.com/neovim/nvim-lspconfig",
		lazy = false,
		--event = { "VimEnter" },
		branch = "master",
		dependencies = {
			{ name = "mason-lspconfig", url = "https://github.com/williamboman/mason-lspconfig.nvim" },
			{ name = "cmp-nvim-lsp", url = "https://github.com/hrsh7th/cmp-nvim-lsp" },
		},
		opts = require("plugins.lsp.lsp").opts,
		config = require("plugins.lsp.lsp").config,
	},

	---@Treesitter
	{
		name = "treesitter",
		enabled = true,
		url = "https://github.com/nvim-treesitter/nvim-treesitter",
		event = { "VimEnter" },
		build = ":TSUpdate",
		config = require("plugins.treesitter.treesitter").config,
	},

	---@Formating
	{
		name = "conform",
		enabled = true,
		url = "https://github.com/stevearc/conform.nvim",
		lazy = false,
		cmd = "ConformInfo",
		dependencies = {
			{ name = "mason", url = "https://github.com/williamboman/mason.nvim" },
		},
		keys = require("plugins.formating.conform").keys,
		opts = require("plugins.formating.conform").opts,
		init = require("plugins.formating.conform").init,
	},

	---@Telescope
	{
		name = "telescope",
		enabled = true,
		url = "https://github.com/nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-project.nvim",
		},
		lazy = false,
		cmd = "Telescope",
		keys = require("plugins.telescope.telescope").keys,
		config = require("plugins.telescope.telescope").config,
	},

	---@Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			{ "fredrikaverpil/neotest-golang", version = "*" },
			"Issafalcon/neotest-dotnet",
		},
		opts = require("plugins.testing.testing").opts,
		config = require("plugins.testing.testing").config,
		-- stylua: ignore
		keys = require("plugins.testing.testing").keys,
	},

	---@DAP
	{
		name = "dap",
		enabled = true,
		url = "https://github.com/mfussenegger/nvim-dap",
		lazy = false,
		dependencies = {
			{
				name = "dap-ui",
				enabled = true,
				url = "https://github.com/rcarriga/nvim-dap-ui",
				lazy = false,
				dependencies = { "nvim-neotest/nvim-nio" },
				keys = require("plugins.dap.dap-ui").keys,
				opts = require("plugins.dap.dap-ui").opts,
				config = require("plugins.dap.dap-ui").config,
			},
			{
				name = "dap-virtual-text",
				enabled = true,
				url = "https://github.com/theHamsta/nvim-dap-virtual-text",
				lazy = false,
				opts = require("plugins.dap.dap-virtual-text").opts,
			},
		},
		keys = require("plugins.dap.dap").keys,
		config = require("plugins.dap.dap").config(),
	},

	---@Editor
	{
		name = "neo-tree",
		enabled = true,
		url = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		cmd = "Neotree",
		dependencies = {
			{ name = "plenary", url = "https://github.com/nvim-lua/plenary.nvim" },
			{ name = "diagnostics", url = "https://github.com/mrbjarksen/neo-tree-diagnostics.nvim" },
			{ name = "icons", url = "https://github.com/nvim-tree/nvim-web-devicons" },
			{ name = "nui", url = "https://github.com/MunifTanjim/nui.nvim" },
		},
		keys = require("plugins.editor.neo-tree").keys,
		init = require("plugins.editor.neo-tree").init,
		deactivate = require("plugins.editor.neo-tree").deactivate,
		opts = require("plugins.editor.neo-tree").opts,
	},

	{
		name = "lualine",
		enabled = true,
		url = "https://github.com/nvim-lualine/lualine.nvim",
		event = "VimEnter",
		opts = require("plugins.editor.lualine.lualine").opts,
		config = require("plugins.editor.lualine.lualine").config,
	},

	{
		"heirline",
		enabled = false,
		url = "https://github.com/rebelot/heirline.nvim",
		--event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		lazy = true,
		opts = function()
			local monokai_opts = require("tools.plugin").opts("monokai-pro.nvim")
			return {
				float = vim.tbl_contains(monokai_opts.background_clear or {}, "neo-tree"),
				colorful = true,
			}
		end,
		config = function(_, opts)
			local heirline = require("plugins.editor.heirline")
			heirline.setup(opts)
			heirline.load()
		end,
	},

	{
		name = "dashboard",
		enabled = true,
		commit = "000448d",
		url = "https://github.com/nvimdev/dashboard-nvim",
		lazy = false,
		dependencies = {
			{ name = "icons", url = "https://github.com/nvim-tree/nvim-web-devicons" },
		},
		keys = require("plugins.editor.dashboard").keys,
		opts = require("plugins.editor.dashboard").opts,
	},

	{
		name = "which-key",
		enabled = true,
		"https://github.com/folke/which-key.nvim",
		lazy = false,
		opts = require("plugins.editor.which-key").opts,
		config = require("plugins.editor.which-key").config,
	},

	{
		name = "git-signs",
		enabled = true,
		url = "https://github.com/lewis6991/gitsigns.nvim",
		lazy = false,
		ft = { "gitcommit", "diff" },
		opts = require("plugins.editor.git-signs").opts,
	},

	{
		name = "git-graph",
		enabled = true,
		url = "https://github.com/isakbm/gitgraph.nvim",
		lazy = false,
		opts = require("plugins.editor.git-graph").opts,
		keys = require("plugins.editor.git-graph").keys,
	},

	-- TODO : bg for buffer information
	{
		name = "buffer-line",
        enabled = true,
		url = "https://github.com/akinsho/bufferline.nvim",
		lazy = false,
		dependencies = {
			{ name = "buffer-delete", url = "https://github.com/famiu/bufdelete.nvim" },
		},
		keys = require("plugins.editor.buffer-line").keys,
		opts = require("plugins.editor.buffer-line").opts,
	},

	-- TODO bg, folds, color for items
	{
		name = "symbols-outline",
		enabled = true,
		url = "https://github.com/simrat39/symbols-outline.nvim",
		lazy = false,
		cmd = "SymbolsOutline",
		keys = require("plugins.editor.symbols-outline").keys,
		dependencies = {
			{ name = "lspconfig", url = "https://github.com/neovim/nvim-lspconfig" },
		},
		opts = require("plugins.editor.symbols-outline").opts,
	},

	---@Ui
	-- {
	-- 	name = "smooth-cursor",
	-- 	enabled = true,
	-- 	url = "https://github.com/gen740/SmoothCursor.nvim",
	-- 	lazy = false,
	-- 	config = require("plugins.ui.smooth-cursor").config,
	-- },

	{
		name = "smear-cursor",
		enabled = true,
		url = "https://github.com/sphamba/smear-cursor.nvim",
		lazy = false,
		opts = require("plugins.ui.smear-cursor").opts,
	},

	{
		name = "indent-blankline",
		enabled = true,
		url = "https://github.com/lukas-reineke/indent-blankline.nvim",
		lazy = false,
		main = "ibl",
		opts = require("plugins.ui.indent-blankline").opts,
	},

	{
		name = "dressing.nvim",
		enabled = true,
		url = "https://github.com/stevearc/dressing.nvim",
		lazy = true,
		init = require("plugins.ui.dressing").init,
		opts = require("plugins.ui.dressing").opts,
	},

	{
		name = "noice",
		enabled = true,
		url = "https://github.com/folke/noice.nvim",
		lazy = false,
		opts = require("plugins.ui.noice").opts,
	},

	{
		name = "notify",
		enabled = true,
		url = "https://github.com/rcarriga/nvim-notify",
		lazy = false,
		keys = require("plugins.ui.notify").keys,
		opts = require("plugins.ui.notify").opts,
		init = require("plugins.ui.notify").init,
	},

	{
		name = "auto-save",
		enabled = true,
		url = "https://github.com/Pocco81/auto-save.nvim",
		lazy = false,
		config = require("plugins.ui.auto-save").config,
	},

	{
		name = "mini-pairs",
		enabled = true,
		url = "https://github.com/echasnovski/mini.nvim",
		lazy = false,
		event = "VeryLazy",
	},

	{
		name = "auto-pairs",
		enabled = true,
		url = "https://github.com/jiangmiao/auto-pairs",
		lazy = false,
	},

	{
		name = "statuscol",
		enabled = true,
		url = "https://github.com/luukvbaal/statuscol.nvim",
		lazy = false,
		commit = require("plugins.ui.statuscol").commit,
		config = require("plugins.ui.statuscol").config,
	},

	-- {
	-- 	name = "scrollbar",
	-- 	enabled = true,
	-- 	url = "https://github.com/petertriho/nvim-scrollbar",
	-- 	lazy = false,
	-- 	opts = require("plugins.ui.scrollbar").opts,
	-- },

	{
		name = "folds",
		enabled = true,
		url = "https://github.com/kevinhwang91/nvim-ufo",
		priority = 1000,
		lazy = false,
		-- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		branch = "main",
		version = false,
		dependencies = {
			{ name = "promise-async", url = "https://github.com/kevinhwang91/promise-async" },
		},
		opts = require("plugins.ui.folds").opts,
		keys = require("plugins.ui.folds").keys,
	},

	{
		name = "mini-patterns",
		enabled = true,
		url = "https://github.com/echasnovski/mini.hipatterns",
		lazy = false,
		--event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = require("plugins.ui.mini-patterns").config,
	},

	{
		name = "windows",
		enabled = true,
		url = "https://github.com/anuvyklack/windows.nvim",
		lazy = false,
		--event = "WinNew",
		dependencies = {
			{ name = "middleclass", url = "https://github.com/anuvyklack/middleclass" },
			{ name = "animation", url = "https://github.com/anuvyklack/animation.nvim" },
		},
		opts = require("plugins.ui.windows").opts,
		keys = require("plugins.ui.windows").keys,
		init = require("plugins.ui.windows").init,
	},

	{
		name = "rainbow_delimiters",
		enabled = true,
		url = "https://github.com/HiPhish/rainbow-delimiters.nvim",
		lazy = false,
		init = require("plugins.ui.rainbow_delimiters").init,
	},

	{
		name = "highlight-colors",
		enabled = true,
		url = "https://github.com/brenoprata10/nvim-highlight-colors",
		lazy = false,
		config = require("plugins.ui.highlight-colors").config,
	},

	-- TODO, FIXME : bugs
	{
		name = "hover",
		enabled = false,
		url = "https://github.com/lewis6991/hover.nvim",
		lazy = false,
		--event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = require("plugins.ui.hover").config,
	},

	-- FIXME : lsp better
	{
		name = "illuminate",
		enabled = true,
		url = "https://github.com/RRethy/vim-illuminate",
		lazy = false,
		-- event = "VeryLazy",
		keys = require("plugins.ui.illuminate").keys,
		opts = require("plugins.ui.illuminate").opts,
		config = require("plugins.ui.illuminate").config,
	},

	-- TODO
	{
		name = "tint",
		enabled = false,
		url = "https://github.com/levouh/tint.nvim",
		lazy = false,
	},

	{
		name = "commentator",
		enabled = true,
		url = "https://github.com/numToStr/Comment.nvim",
		lazy = false,
		opts = require("plugins.ui.commentator").opts,
	},

	-- {
	-- 	"aveplen/ruscmd.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		abbreviations = true,
	-- 		keymaps = true,
	-- 	},
	-- },

	-- {
	-- 	"folke/flash.nvim",
	-- 	vscode = true,
	-- 	opts = {},
	-- 	-- stylua: ignore
	-- 	keys = {
	-- 	  { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	-- 	  { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	-- 	  { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	-- 	  { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	-- 	  { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	-- 	},
	-- }
}

-- filetypes: man
