--------Mappings-----------
map("n", "j", "gj", NS)
map("n", "k", "gk", NS)
map("n", "<Esc>", ":noh<cr>:echo ''<cr>", NS)
map("v", "<", "<gv", NS)
map("v", ">", ">gv", NS)
map("i", "jk", "<Esc>", NS)

map("c", "<Down>", "<C-n>", {})
map("c", "<Up>", "<C-p>", {})
-- HELP
map("n", "<leader>hrs", ":source %<cr>", {noremap = true})
map("n", "<leader>hrr", ":source %<cr>:PackerSync<cr>", NS)
map("n", "<leader>hrc", ":source %<cr>:PackerCompile profile=true<cr>", {noremap = true})
map("n", "<leader>hrp", ":source %<cr>:PackerProfile<cr>", {noremap = true})
-- FILE
map("n", "<leader>fs", ":silent up<cr>", NS)
map("n", "s", "<nop>", NS)
map("n", "ss", ":silent up<cr>", NS)
-- save all files
map("n", "<leader>bs", ":wa<cr>", NS)

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
map("t", "dj", "<C-\\><C-n><C-w>j", NS)
map("t", "dk", "<C-\\><C-n><C-w>k", NS)
map("t", "dl", "<C-\\><C-n><C-w>l", NS)

-- terminal
map("n", "<leader>oT", ":terminal<cr>", NS)
map("t", "ss", "<C-\\><C-n>", NS)
map("t", "sd", "<C-\\><C-n><C-w>c", NS)
map("n", "sd", "<C-w>c", NS)

-- buffer
-- map("n", "<leader>bk", ":bw!<cr>", NS)

-- search result appear in the middle of screen
map("n", "n", "nzz", NS)
map("n", "N", "Nzz", NS)
-- move line up and down
map("i", "<M-Down>", "<Esc>:m .+1<cr>==gi", NS)
map("i", "<M-Up>", "<Esc>:m .-2<cr>==gi", NS)
map("n", "<M-Down>", ":m .+1<cr>==", NS)
map("n", "<M-Up>", ":m .-2<cr>==", NS)
map("v", "<M-Down>", ":m '>+1<cr>gv=gv", NS)
map("v", "<M-Up>", ":m '<-2<cr>gv=gv", NS)
-- make y copy
map("n", "Y", "y$", NS)

-- undo break point
map("i", ",", ",<C-g>u", NS)
map("i", ".", ".<C-g>u", NS)
map("i", "!", "!<C-g>u", NS)
map("i", "?", "?<C-g>u", NS)
map("i", "[", "[<C-g>u", NS)
-- map("i", " ", " <C-g>u", NS)

-- don't lose indent with esc
map("i", "<cr>", "<cr>x<bs>", NS)
-- map("n", "o", "ox<bs>", NS)
-- map("n", "O", "Ox<bs>", NS)
-- map("n", "S", "Sx<bs>", NS)

-- terminal git push
map("n", "<leader>gp", ":sp term://git push origin $(git rev-parse --abbrev-ref HEAD)<cr>i", NS)
map("n", "<leader>gf", ":sp term://git pull origin $(git rev-parse --abbrev-ref HEAD)<cr>i", NS)

-- select non blank line
map("n", "vv", "^vg_", NS)

-- switch buffer
map("n", "``", "<C-^>", NS)
map("n", "<leader>`", "<C-^>", NS)
