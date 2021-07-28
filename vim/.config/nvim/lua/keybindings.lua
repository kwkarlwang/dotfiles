local opts = {noremap = true, silent = true}
--------Mappings-----------
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)
map("n", "<Esc>", ":noh<cr>:echo ''<cr>", opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("i", "jk", "<Esc>", opts)
map("c", "<Down>", 'wildmenumode() ? "<C-n>" : "\\<Down>"', opts)
map("c", "<Up>", 'wildmenumode() ? "<C-p>" : "\\<Up>"', opts)
-- HELP
map("n", "<leader>hs", ":so %<cr>", opts)
map("n", "<leader>hr", ":so %<cr>:PackerSync<cr>", opts)
-- FILE
map("n", "<leader>fs", ":silent w<cr>", opts)

-- WINDOWS
map("n", "<leader>wd", "<C-w>c", opts)
map("n", "<leader>w<", "30<C-w><", opts)
map("n", "<leader>w>", "30<C-w>>", opts)
map("n", "<leader>w+", "10<C-w>+", opts)
map("n", "<leader>w-", "10<C-w>-", opts)

map("n", "<leader>w", "<C-w>", opts)
map("n", "<leader>wm", ":tabnew %<cr>", opts)

-- buffer
map("n", "<leader>bk", ":bw!<cr>", opts)

-- terminal
map("n", "<leader>oT", ":terminal<cr>", opts)
map("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
map("t", "<Esc><leader>w", "<C-\\><C-n><C-w>", opts)
map("t", "<Esc><leader>wd", "<C-\\><C-n><C-w>c", opts)
map("t", "<Esc><leader>w<", "<C-\\><C-n>30<C-w><", opts)
map("t", "<Esc><leader>w>", "<C-\\><C-n>30<C-w>>", opts)
map("t", "<Esc><leader>w+", "<C-\\><C-n>10<C-w>+", opts)
map("t", "<Esc><leader>w-", "<C-\\><C-n>10<C-w>-", opts)
map("t", "<Esc><leader>bk", "<C-\\><C-n>:bw!<cr>", opts)
-- map("t", "<Esc><Esc>", "<Esc>", opts)
-- map("t", "<Esc>b", "<Esc>b", opts)
-- map("t", "<C-c>", "<Esc>", opts)
-- map("t", "<C-c><C-c>", "<C-c>", opts)

-- File manager
-- map("n", "<leader>.", ":Explore<cr>", {noremap = true, silent = true})

-- search result appear in the middle of screen
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- move line up and down
map("i", "<M-Down>", "<Esc>:m .+1<cr>gi", opts)
map("i", "<M-Up>", "<Esc>:m .-2<cr>gi", opts)
map("n", "<M-Down>", ":m .+1<cr>", opts)
map("n", "<M-Up>", ":m .-2<cr>", opts)
map("v", "<M-Down>", ":m '>+1<cr>gv-gv", opts)
map("v", "<M-Up>", ":m '<-2<cr>gv-gv", opts)
