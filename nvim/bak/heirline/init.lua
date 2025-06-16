local conditions = require("heirline.conditions")

local config = require("plugins.editor.heirline.config")

local M = {}

M.setup = config.setup

function M.load()
  local statusline = require("plugins.editor.heirline.statusline")
  local palette = require("plugins.editor.heirline.palette").setup(config)

  require("heirline").setup({
    statusline = statusline.value,
    opts = {
      colors = palette.get,
      disable_winbar_cb = function(args)
        if vim.bo[args.buf].filetype == "neo-tree" then
          return
        end
        return conditions.buffer_matches({
          buftype = { "nofile", "prompt", "help", "quickfix" },
          filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
        }, args.buf)
      end,
    },
  })
end

return M
