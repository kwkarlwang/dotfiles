local expr = {noremap = true, silent = true, expr = true}
--------Mappings-----------
map("n", "<Esc>", ":noh<cr>:echo ''<cr>", NS)
map("v", "<", "<gv", NS)
map("v", ">", ">gv", NS)
map("i", "jk", "<Esc>", NS)
map("c", "<Down>", "wildmenumode() ? '<C-n>' : '\\<Down>'", expr)
map("c", "<Up>", "wildmenumode() ? '<C-p>' : '\\<Up>'", expr)
-- map("c", "<Down>", "<C-n>", NS)
-- map("c", "<Up>", "<C-p>", NS)
-- HELP
map("n", "<leader>hrs", ":source $MYVIMRC<cr>", {noremap = true})
map("n", "<leader>hrr", ":source $MYVIMRC<cr>:PackerSync<cr>", NS)
map("n", "<leader>hrc", ":source $MYVIMRC<cr>:PackerCompile profile=true<cr>", {noremap = true})
map("n", "<leader>hrp", ":source $MYVIMRC<cr>:PackerProfile<cr>", {noremap = true})
-- FILE
map("n", "<leader>fs", ":silent up<cr>", NS)
-- save all files
map("n", "<leader>bs", ":wa <cr>", NS)

-- WINDOWS
map("n", "<leader>wd", "<C-w>c", NS)
map("n", "<leader>w<", "30<C-w><", NS)
map("n", "<leader>w>", "30<C-w>>", NS)
map("n", "<leader>w+", "10<C-w>+", NS)
map("n", "<leader>w-", "10<C-w>-", NS)
map("n", "<leader>w", "<C-w>", NS)
map("n", "<leader>wm", ":tabnew %<cr>", NS)

-- buffer
-- map("n", "<leader>bk", ":bw!<cr>", NS)

-- terminal
map("n", "<leader>oT", ":terminal<cr>", NS)
-- map("t", "<Esc>", "<C-\\><C-n>", NS)
-- map("t", "<C-s>", "<Esc>", NS)
-- map("t", "<C-w>", "<C-\\><C-n><C-w>", NS)
map("t", "jk", "<C-\\><C-n>", NS)

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
map("i", " ", " <C-g>u", NS)

-- don't lose indent with esc
map("i", "<cr>", "<cr>x<bs>", NS)
map("n", "o", "ox<bs>", NS)
map("n", "O", "Ox<bs>", NS)
map("n", "S", "Sx<bs>", NS)

--navigation
map("n", "sh", "<C-w>h", NS)
map("n", "sj", "<C-w>j", NS)
map("n", "sk", "<C-w>k", NS)
map("n", "sl", "<C-w>l", NS)

map("t", "sh", "<C-\\><C-n><C-w>h", NS)
map("t", "sj", "<C-\\><C-n><C-w>j", NS)
map("t", "sk", "<C-\\><C-n><C-w>k", NS)
map("t", "sl", "<C-\\><C-n><C-w>l", NS)

-- terminal git push
map("n", "<leader>gp", ":sp term://git push origin HEAD<cr>", NS)
