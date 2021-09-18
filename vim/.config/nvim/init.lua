vim = vim
cmd = vim.cmd
fn = vim.fn
g = vim.g
map = vim.api.nvim_set_keymap
o = vim.opt
api = vim.api
lsp = vim.lsp
bufmap = vim.api.nvim_buf_set_keymap

NS = { noremap = true, silent = true }

pcall(require("impatient"))
require("settings")
require("keybindings")
require("plugins")

-- cmd("set rtp+=~/projects/neovim/bufjump.nvim")
-- local cfg = {
-- 	on_success = function()
-- 		vim.cmd([[execute "normal! g`\"zz"]])
-- 	end,
-- }
-- require("bufjump").setup(cfg)
