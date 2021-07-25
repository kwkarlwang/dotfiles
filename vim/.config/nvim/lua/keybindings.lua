--------Mappings-----------
map("n", "j", "gj", {noremap = true})
map("n", "k", "gk", {noremap = true})
map("n", "<Esc>", ":noh<cr>:echo ''<cr>", {noremap = true, silent = true})
map("v", "<", "<gv", {noremap = true})
map("v", ">", ">gv", {noremap = true})
map("i", "jk", "<Esc>", {noremap = true})
map("c", "<Down>", 'wildmenumode() ? "<C-n>" : "\\<Down>"', {expr = true, noremap = true})
map("c", "<Up>", 'wildmenumode() ? "<C-p>" : "\\<Up>"', {expr = true, noremap = true})
-- HELP
map("n", "<leader>hs", ":so %<cr>", {noremap = true, silent = true})
map("n", "<leader>hr", ":so %<cr>:PackerSync<cr>", {noremap = true, silent = true})
-- FILE
map("n", "<leader>fs", ":w<cr>", {noremap = true, silent = true})

-- WINDOWS
map("n", "<leader>wd", "<C-w>c", {noremap = true, silent = true})
map("n", "<leader>w<", "30<C-w><", {noremap = true, silent = true})
map("n", "<leader>w>", "30<C-w>>", {noremap = true, silent = true})
map("n", "<leader>w+", "5<C-w>+", {noremap = true, silent = true})
map("n", "<leader>w-", "5<C-w>-", {noremap = true, silent = true})
map("n", "<leader>wm", "<C-w>o", {noremap = true, silent = true})

map("n", "<leader>w", "<C-w>", {noremap = true, silent = true})

-- buffer
map("n", "<leader>bk", ":bw!<cr>", {noremap = true, silent = true})

-- terminal
map("n", "<leader>oT", ":terminal<cr>", {noremap = true, silent = true})
map("t", "<Esc>", "<C-\\><C-n>", {noremap = true})
map("t", "<C-c>", "<Esc>", {noremap = true, silent = true})

-- File manager
map("n", "<leader>.", ":Explore<cr>", {noremap = true, silent = true})

-- search result appear in the middle of screen
map("n", "n", "nzz", {noremap = true, silent = true})
map("n", "N", "Nzz", {noremap = true, silent = true})
