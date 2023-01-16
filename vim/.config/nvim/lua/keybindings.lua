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
map("n", "ss", "<cmd>silent up<cr><cmd>lua AsyncFormat()<cr>", NS)

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

-- map("t", "dh", "<C-\\><C-n><C-w>h", NS)
-- map("t", "dj", "<C-\\><C-n><C-w>j", NS)
-- map("t", "dk", "<C-\\><C-n><C-w>k", NS)
-- map("t", "dl", "<C-\\><C-n><C-w>l", NS)

-- terminal
map("n", "<leader>oT", ":terminal<cr>", NS)
map("t", "<C-cr>", "<C-\\><C-n>", NS)
-- map(
-- 	"t",
-- 	"sd",
-- 	"<C-\\><C-n>"
-- 		.. ":lua require('bufresize').block_register()<cr>"
-- 		.. "<C-w>c"
-- 		.. ":lua require('bufresize').resize_close()<cr>",
-- 	NS
-- )
map(
	"n",
	"sd",
	":lua require('bufresize').block_register()<cr>" .. "<C-w>c" .. ":lua require('bufresize').resize_close()<cr>",
	NS
)

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

-- begin and end of line in insert mode
map("i", "<C-q>", "<C-o>I", NS)
map("i", "<C-e>", "<C-o>A", NS)

-- get highlight under cursor
map("n", "<leader>hg", [[:echo synIDattr(synID(line("."), col("."), 1), "name")<cr>]], {})

-- quickfix list
map("n", "cn", ":cnext<cr>", NS)
map("n", "cp", ":cprev<cr>", NS)
map("n", "co", ":copen<cr>", NS)
