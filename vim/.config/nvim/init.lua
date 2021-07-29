cmd = vim.cmd
fn = vim.fn
g = vim.g
map = vim.api.nvim_set_keymap
o = vim.opt
bufmap = vim.api.nvim_buf_set_keymap

require "plugins"
require "settings"
require "keybindings"
