local tree_cb = require "nvim-tree.config".nvim_tree_callback
map("n", "<leader>op", ":NvimTreeToggle<cr>", {noremap = true, silent = true})
g.nvim_tree_bindings = {
  {key = {"l"}, cb = tree_cb("edit")},
  {key = {"h"}, cb = tree_cb("close_node")},
  {key = {"o"}, cb = tree_cb("cd")}
}

g.nvim_tree_auto_close = 1
g.nvim_tree_width = 40
g.nvim_tree_auto_open = 0
g.nvim_tree_quit_on_open = 1
g.nvim_tree_follow = 1

-- netrw, 1 is disable
g.nvim_tree_disable_netrw = 1
g.nvim_tree_hijack_netrw = 1
