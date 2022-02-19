--------Mappings-----------
map("n", "j", "gj", NS)
map("n", "k", "gk", NS)
map("n", "0", "g0", NS)
map("n", "$", "g$", NS)
map("n", "<Esc>", ":noh<cr>:echo ''<cr>", NS)
map("v", "<", "<gv", NS)
map("v", ">", ">gv", NS)
map("i", "jk", "<Esc>", NS)

map("c", "<Down>", "<C-n>", {})
map("c", "<Up>", "<C-p>", {})
-- HELP
map("n", "<leader>ps", ":source %<cr>", { noremap = true })
map("n", "<leader>pp", ":source %<cr>:PackerSync<cr>", NS)
map("n", "<leader>pc", ":source %<cr>:PackerCompile profile=true<cr>", { noremap = true })
map("n", "<leader>pP", ":source %<cr>:PackerProfile<cr>", { noremap = true })
-- FILE
map("n", "<leader>fs", ":silent up<cr>", NS)
map("n", "s", "<nop>", NS)
-- save all files
map("n", "sa", ":wa<cr>", NS)
map("n", "ss", ":silent up<cr>", NS)

-- WINDOWS
map("n", "<leader>wd", "<C-w>c", NS)
map("n", "<leader>w<", "30<C-w><", NS)
map("n", "<leader>w>", "30<C-w>>", NS)
map("n", "<leader>w+", "10<C-w>+", NS)
map("n", "<leader>w-", "10<C-w>-", NS)
map("n", "<leader>w", "<C-w>", NS)
map("n", "<leader>wo", "<C-w>|<C-w>_", NS)
map("n", "<leader>wm", ":tabnew %<cr>", NS)

--navigation
map("n", "dh", "<C-w>h", NS)
map("n", "dj", "<C-w>j", NS)
map("n", "dk", "<C-w>k", NS)
map("n", "dl", "<C-w>l", NS)

map("t", "dh", "<C-\\><C-n><C-w>h", NS)
-- map("t", "dj", "<C-\\><C-n><C-w>j", NS)
map("t", "dk", "<C-\\><C-n><C-w>k", NS)
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

-- move line up and down
map("i", "<M-Down>", "<Esc>:m .+1<cr>==gi", NS)
map("i", "<M-Up>", "<Esc>:m .-2<cr>==gi", NS)
map("n", "<M-Down>", ":m .+1<cr>==", NS)
map("n", "<M-Up>", ":m .-2<cr>==", NS)
map("v", "<M-Down>", ":m '>+1<cr>gv=gv", NS)
map("v", "<M-Up>", ":m '<-2<cr>gv=gv", NS)

-- y/Y
map("v", "y", "ygv<esc>", NS)

-- undo break point
map("i", ",", ",<C-g>u", NS)
map("i", ".", ".<C-g>u", NS)
map("i", "!", "!<C-g>u", NS)
map("i", "?", "?<C-g>u", NS)
map("i", "[", "[<C-g>u", NS)

-- don't lose indent with esc
map("i", "<cr>", "<cr>x<bs>", NS)

-- terminal git push
-- map("n", "<leader>gp", ":sp term://git push -u origin $(git rev-parse --abbrev-ref HEAD)<cr>i", NS)
-- map("n", "<leader>gf", ":sp term://git pull origin $(git rev-parse --abbrev-ref HEAD)<cr>i", NS)

-- select non blank line
map("n", "vv", "^vg_", NS)

-- switch buffer
map("n", "``", "<C-^>", NS)
map("n", "<leader>`", "<C-^>", NS)

-- quit
map("n", "<leader>qq", ":wa<cr>:qa<cr>", NS)
map("n", "<leader>qQ", ":qa!<cr>", NS)

-- highlight
map("n", "*", "*Nn", { silent = true })
map("n", "#", "#Nn", { silent = true })
map("n", "gf", "*N", { silent = true })

-- Move to first and end
map("n", "H", "g^", NS)
map("n", "L", "g$", NS)
map("v", "H", "g^", NS)
map("v", "L", "g$", NS)

-- Toggle spell
map("n", "<leader>ts", ":setlocal spell!<cr>", NS)
