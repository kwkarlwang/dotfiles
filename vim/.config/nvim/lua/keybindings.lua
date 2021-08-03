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
map("n", "<leader>hrs", ":so $MYVIMRC<cr>", NS)
map("n", "<leader>hrr", ":so $MYVIMRC<cr>:PackerSync<cr>", NS)
map("n", "<leader>hrc", ":so $MYVIMRC<cr>:PackerCompile profile=true<cr>", {noremap = true})
map("n", "<leader>hrp", ":so $MYVIMRC<cr>:PackerProfile<cr>", {noremap = true})
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
map("t", "<Esc>", "<C-\\><C-n>", NS)
map("t", "<C-s>", "<Esc>", NS)

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
cmd [[
    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
    inoremap <A-h> <C-\><C-N><C-w>h
    inoremap <A-j> <C-\><C-N><C-w>j
    inoremap <A-k> <C-\><C-N><C-w>k
    inoremap <A-l> <C-\><C-N><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
]]

-- terminal git push
map("n", "<leader>gp", "sp term://git push", NS)
