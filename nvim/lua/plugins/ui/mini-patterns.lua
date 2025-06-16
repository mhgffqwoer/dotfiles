local M = {}

M.config = function()
  require("mini.hipatterns").setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      wip = { pattern = "%f[%w]()WIP()%f[%W]", group = "MiniHipatternsWip" },
      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = require("mini.hipatterns").gen_highlighter.hex_color({ priority = 2000 }),
    },
  })
end

return M 