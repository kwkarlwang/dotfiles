local tree_cb = require "nvim-tree.config".nvim_tree_callback
map("n", "<leader>op", ":NvimTreeToggle<cr>", {noremap = true, silent = true})
g.nvim_tree_bindings = {
  {key = {"l"}, cb = tree_cb("edit")},
  {key = {"h"}, cb = tree_cb("close_node")},
  {key = {"o"}, cb = tree_cb("cd")}
}

g.nvim_tree_auto_close = 1
g.nvim_tree_width = 40
