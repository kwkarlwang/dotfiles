---@diagnostic disable: lowercase-global
fn = vim.fn
g = vim.g
map = vim.api.nvim_set_keymap
o = vim.opt
api = vim.api
lsp = vim.lsp
bufmap = vim.api.nvim_buf_set_keymap

NS = { noremap = true, silent = true }

home_dir = os.getenv("HOME") .. "/"

require("settings")
require("keybindings")
require("plugin").setup("plugins")
vim.lsp.set_log_level("error")
