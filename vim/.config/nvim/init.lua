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
require("plugin")
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
	vim.api.nvim_set_hl(0, group, {})
end
vim.lsp.set_log_level("error")

-- vim.cmd("set rtp+=~/projects/neovim/nvim-jupyter")
-- require("nvim-jupyter").setup()
-- map("n", "<leader>jp", "<cmd>lua require('nvim-jupyter').find_prev()<cr>", NS)
-- map("n", "<leader>jn", "<cmd>lua require('nvim-jupyter').find_next()<cr>", NS)
-- map("n", "<leader>js", "<cmd>lua require('nvim-jupyter').insert_below()<cr>", NS)
-- map("n", "<leader>jj", "<cmd>lua require('nvim-jupyter').send_to_kernel()<cr>", NS)
-- map("n", "<C-cr>", "<cmd>lua require('nvim-jupyter').eval_cell()<cr>", NS)
-- map("i", "<C-cr>", "<C-o><cmd>lua require('nvim-jupyter').eval_cell()<cr>", NS)
-- map("n", "<S-cr>", "<cmd>lua require('nvim-jupyter').eval_cell_and_move()<cr>", NS)
-- map("i", "<S-cr>", "<C-o><cmd>lua require('nvim-jupyter').eval_cell_and_move()<cr>", NS)

-- vim.cmd("set rtp+=~/projects/neovim/bufresize.nvim")
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
