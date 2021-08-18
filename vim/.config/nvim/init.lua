vim = vim
cmd = vim.cmd
fn = vim.fn
g = vim.g
map = vim.api.nvim_set_keymap
o = vim.opt
api = vim.api
lsp = vim.lsp
bufmap = vim.api.nvim_buf_set_keymap

NS = {noremap = true, silent = true}

require "settings"
require "keybindings"
require "plugins"
