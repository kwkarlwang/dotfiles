vim = vim
fn = vim.fn
g = vim.g
map = vim.api.nvim_set_keymap
o = vim.opt
api = vim.api
lsp = vim.lsp
bufmap = vim.api.nvim_buf_set_keymap

NS = { noremap = true, silent = true }

pcall(require, "impatient")
require("settings")
require("keybindings")
require("plugins")

--vim.cmd("set rtp+=~/projects/neovim/bufresize.nvim")
--require("cmp_nvim_insert_text_lsp").setup()

-- require("bufresize").setup({
-- 	register = {
-- 		keys = {
-- 			{ "n", "<leader>w<", "30<C-w><", NS },
-- 			{ "n", "<leader>w>", "30<C-w>>", NS },
-- 			{ "n", "<leader>w+", "10<C-w>+", NS },
-- 			{ "n", "<leader>w-", "10<C-w>-", NS },
-- 			{ "n", "<leader>w_", "<C-w>_", NS },
-- 			{ "n", "<leader>w=", "<C-w>=", NS },
-- 			{ "n", "<leader>w|", "<C-w>|", NS },
-- 			{ "n", "<leader>wo", "<C-w>|<C-w>_", NS },
-- 		},
-- 		trigger_events = { "BufWinEnter", "WinEnter" },
-- 	},
-- 	resize = {
-- 		keys = {},
-- 		trigger_events = { "VimResized" },
-- 		increment = 5,
-- 	},
-- })
--map("n", "<leader>p", ":lua require('bufresize').debug()<cr>", NS)
