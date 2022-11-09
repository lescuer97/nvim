local nnoremap = require("keymap").nnoremap
nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap( "<C-p>", "<cmd>FzfLua files<CR>") 
nnoremap("<C-h>","<cmd>tabprevious<CR>")
nnoremap("<C-l>", "<cmd>tabnext<CR>")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
