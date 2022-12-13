local nnoremap = require("keymap").nnoremap
local FzfLua = require("fzf-lua");

nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap( "<C-p>",  "<cmd>lua require('fzf-lua').files({ cmd = 'fdfind -I --exclude build/ --exclude node_modules/ --exclude archive/' })<CR>") 
nnoremap( "<C-g>",  "<cmd>lua require('fzf-lua').live_grep_glob({filter = [[rg --invert-match 'node_modules/|build/|archive/|dist/|.git/|Cargo.lock|package-lock.json|LICENSES.txt|LICENSES.json']]})<CR>") 
nnoremap("<C-h>","<cmd>tabprevious<CR>")
nnoremap("<C-l>", "<cmd>tabnext<CR>")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
