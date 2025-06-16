local M = {}

M.friendly_snippets_config = function()
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
end

M.config = function()
	local ls = require("luasnip")

	-- Загрузка сниппетов
	require("luasnip.loaders.from_vscode").lazy_load()

	require("luasnip").filetype_extend("go", { "go" })
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/Users/arsenijaksevic/.config/nvim/lua/plugins/coding/snippets" } })
	require("luasnip.loaders.from_lua").load({ paths = { "/Users/arsenijaksevic/.config/nvim/lua/plugins/coding/snippets" } })
	-- Настройка LuaSnip
	ls.setup({
		history = true,
		delete_check_events = "TextChanged",
	})

	-- Маппинги для навигации по сниппетам
	vim.keymap.set({ "i", "s" }, "<c-]>", function() ls.jump(1) end, { silent = true })
	vim.keymap.set({ "i", "s" }, "<c-[>", function() ls.jump(-1) end, { silent = true })
end

return M
