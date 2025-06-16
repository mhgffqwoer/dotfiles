_G.Icons = require("core.icons")

local function setup()
	require("core.autocmds")
	require("core.commands")
	require("core.keymaps")
end

local function init()
	require("core.options")
	require("core.lazy")
	if vim.g.neovide then
		require("core.neovide")
	end
end

init()

return {
	setup = setup,
}