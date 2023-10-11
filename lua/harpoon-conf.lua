local mark = require("harpoon.mark");
local ui = require("harpoon.ui");
local nnoremap = require("keymap").nnoremap

nnoremap("<leader>a", mark.add_file)
nnoremap("<leader>r", mark.rm_file)
nnoremap("<leader>h", ui.toggle_quick_menu)
nnoremap("<leader>e", function ()
    mark.clear_all();
end )

nnoremap("<leader>1",function ()
  ui.nav_file(1);
end )
nnoremap("<leader>2",function ()
  ui.nav_file(2);
end )
nnoremap("<leader>3",function ()
  ui.nav_file(3);
end )
nnoremap("<leader>4",function ()
  ui.nav_file(4);
end )
nnoremap("<leader>5",function ()
  ui.nav_file(5);
end )
nnoremap("<leader>6",function ()
  ui.nav_file(6);
end )

