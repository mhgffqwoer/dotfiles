local map = require("tools.safe_keymap").safe_keymap_set
local surround_visual = require("tools.surround").surround_visual

map('n', '<leader>R', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = '[Nvim] Redraw' })
-------------------- General Mappings --------------------------
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "[Nvim] Quit all" })
map("n", "<leader>q", "<cmd>q!<CR>", { desc = "[Nvim] Quit" })

map("n", "<leader>d", function() require("bufdelete").bufdelete(0, false) end, { desc = "[Nvim] Buffer close" })

-------------------- Better window navigation ------------------
map("n", "<M-Right>", "<C-w>l", { desc = "[Window] Go to right", remap = true })
map("n", "<M-Left>", "<C-w>h", { desc = "[Window] Go to left", remap = true })

-------------------- Lazy Mappings --------------------------
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "[Lazy] Open", remap = true })

-------------------- Surround Mappings --------------------------
map("v", "(", surround_visual("(", ")"), { noremap = true, silent = true })
map("v", ")", surround_visual("(", ")"), { noremap = true, silent = true })
map("v", "[", surround_visual("[", "]"), { noremap = true, silent = true })
map("v", "]", surround_visual("[", "]"), { noremap = true, silent = true })
map("v", "{", surround_visual("{", "}"), { noremap = true, silent = true })
map("v", "}", surround_visual("{", "}"), { noremap = true, silent = true })
map("v", "\"", surround_visual("\"", "\""), { noremap = true, silent = true })
map("v", "`", surround_visual("`", "`"), { noremap = true, silent = true })
map("v", "'", surround_visual("'", "'"), { noremap = true, silent = true })
