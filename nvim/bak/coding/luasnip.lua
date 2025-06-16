return {
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = {
			{
			  "rafamadriz/friendly-snippets",
			  config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
			  end,
			},
		},
		config = function()
		  local ls = require("luasnip")
	  
		  -- Загрузка сниппетов
		  require("luasnip.loaders.from_vscode").lazy_load()
	  
		  -- Настройка LuaSnip
		  ls.setup({
			history = true,
			delete_check_events = "TextChanged",
		  })
	  
		  -- Маппинги для навигации по сниппетам
			vim.keymap.set({"i", "s"}, "}", function() ls.jump( 1) end, {silent = true})
			vim.keymap.set({"i", "s"}, "{", function() ls.jump(-1) end, {silent = true})
		end,
	},
}