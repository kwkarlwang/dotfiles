--------Mappings-----------
map("n", "j", "gj", NS)
map("n", "k", "gk", NS)
map("n", "<Esc>", ":noh<cr>:echo ''<cr><cr>", NS)
map("v", "<", "<gv", NS)
map("v", ">", ">gv", NS)
map("i", "jk", "<Esc>", NS)

map("c", "<Down>", "<C-n>", {})
map("c", "<Up>", "<C-p>", {})
-- HELP
map("n", "<leader>pp", "<cmd>Lazy<cr>", NS)
-- FILE
map("n", "<leader>fs", ":silent up<cr>", NS)
map("n", "s", "<nop>", NS)
-- save all files
map("n", "sa", ":wa<cr>", NS)
-- vim.keymap.set("n", "ss", function() AsyncFormat() end)

-- WINDOWS
map("n", "<leader>wd", "<C-w>c", NS)
map("n", "<leader>w<", "30<C-w><", NS)
map("n", "<leader>w>", "30<C-w>>", NS)
map("n", "<leader>w+", "10<C-w>+", NS)
map("n", "<leader>w-", "10<C-w>-", NS)
map("n", "<leader>w", "<C-w>", NS)
map("n", "<leader>wo", "<C-w>|<C-w>_", NS)
map("n", "<leader>wm", ":tabnew %<cr>", NS)

-- navigation
map("n", "dh", "<C-w>h", NS)
map("n", "dj", "<C-w>j", NS)
map("n", "dk", "<C-w>k", NS)
map("n", "dl", "<C-w>l", NS)

-- terminal
map("n", "<leader>oT", ":terminal<cr>", NS)
map("t", "<C-cr>", "<C-\\><C-n>", NS)
map("n", "sd", "<C-w>c", NS)

-- y/Y
map("v", "y", "ygv<esc>", NS)

-- undo break point
map("i", ",", ",<C-g>u", NS)
map("i", ".", ".<C-g>u", NS)
map("i", "!", "!<C-g>u", NS)
map("i", "?", "?<C-g>u", NS)
map("i", "[", "[<C-g>u", NS)

-- select non blank line
map("n", "vv", "^vg_", NS)

-- switch buffer
map("n", "``", "<C-^>", NS)
map("n", "<leader>`", "<C-^>", NS)

-- quit
map("n", "<leader>q", ":wa<cr>:qa<cr>", NS)

-- highlight
map("n", "*", "*Nn", { silent = true })
map("n", "#", "#Nn", { silent = true })
map("n", "gf", "*N", { silent = true })

-- Move to first and end
map("n", "H", "g^", NS)
map("n", "L", "g$", NS)
map("x", "H", "g^", NS)
map("x", "L", "g$", NS)

-- Toggle spell
map("n", "<leader>ts", ":setlocal spell!<cr>", NS)

-- Record macro
map("n", "Q", "q", NS)

-- Add ; to end of the line
map("n", "<C-;>", "m`A;<esc>``", NS)
map("i", "<C-;>", "<C-o>m`<C-o>A;<esc>``", NS)

map("n", "<C-,>", "m`A,<esc>``", NS)
map("i", "<C-,>", "<C-o>m`<C-o>A,<esc>``", NS)

-- begin and end of line in insert mode
map("i", "<C-q>", "<C-o>I", NS)
map("i", "<C-e>", "<C-o>A", NS)

-- get highlight under cursor
map("n", "<leader>hg", [[<cmd>Inspect<cr>]], {})

-- quickfix list
map("n", "cn", ":cnext<cr>", NS)
map("n", "cp", ":cprev<cr>", NS)
map("n", "co", ":copen<cr>", NS)
map("n", "cl", ":cclose<cr>", NS)

-- tab
map("n", "gn", "gt", NS)
map("n", "gp", "gT", NS)
