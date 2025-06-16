local conditions = require("heirline.conditions")
local config = require("plugins.editor.heirline.config")
local cpn = require("plugins.editor.heirline.components")

local M = {}

local DefaultStatusLine = {
  cpn.git(),
  cpn.diagnostic(),
  cpn.justify, ---------------------------------------------------------------
  cpn.aisync({ "copilot" }),
  cpn.position(),
  cpn.filetype(),
  cpn.shiftwidth(),
  cpn.mode(),
}

M.value = {
  -- hl = function()
  --   if conditions.is_active() then
  --     if config.float then
  --       return "Normal"
  --     end
  --     return "StatusLine"
  --   else
  --     return "StatusLineNC"
  --   end
  -- end,
  -- static = {
  --   mode_colors = {
  --     n = "red",
  --     i = "green",
  --     v = "blue",
  --     V = "blue",
  --     ["\22"] = "cyan", -- this is an actual ^V, type <C-v><C-v> in insert mode
  --     c = "orange",
  --     s = "purple",
  --     S = "purple",
  --     ["\19"] = "purple", -- this is an actual ^S, type <C-v><C-s> in insert mode
  --     R = "orange",
  --     r = "orange",
  --     ["!"] = "red",
  --     t = "green",
  --   },
  --   mode_color = function(self)
  --     local mode = conditions.is_active() and vim.fn.mode() or "n"
  --     return self.mode_colors[mode]
  --   end,
  -- },
  DefaultStatusLine,
}

return M
