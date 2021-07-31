local opts = {noremap = true, silent = true}
local expr = {noremap = true, silent = true, expr = true}
--------Mappings-----------
map("n", "<Esc>", ":noh<cr>:echo ''<cr>", opts)
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("i", "jk", "<Esc>", opts)
map("c", "<Down>", "wildmenumode() ? '<C-n>' : '\\<Down>'", expr)
map("c", "<Up>", "wildmenumode() ? '<C-p>' : '\\<Up>'", expr)
-- map("c", "<Down>", "<C-n>", opts)
-- map("c", "<Up>", "<C-p>", opts)
-- HELP
map("n", "<leader>hs", ":so %<cr>", opts)
map("n", "<leader>hr", ":so %<cr>:PackerSync<cr>", opts)
-- FILE
map("n", "<leader>fs", ":silent up<cr>", opts)
-- save all files
map("n", "<leader>bs", ":wa <cr>", opts)

-- WINDOWS
map("n", "<leader>wd", "<C-w>c", opts)
map("n", "<leader>w<", "30<C-w><", opts)
map("n", "<leader>w>", "30<C-w>>", opts)
map("n", "<leader>w+", "10<C-w>+", opts)
map("n", "<leader>w-", "10<C-w>-", opts)
map("n", "<leader>w", "<C-w>", opts)
map("n", "<leader>wm", ":tabnew %<cr>", opts)

-- buffer
-- map("n", "<leader>bk", ":bw!<cr>", opts)

-- terminal
map("n", "<leader>oT", ":terminal<cr>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)
map("t", "<C-s>", "<Esc>", opts)

-- search result appear in the middle of screen
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)
-- move line up and down
map("i", "<M-Down>", "<Esc>:m .+1<cr>==gi", opts)
map("i", "<M-Up>", "<Esc>:m .-2<cr>==gi", opts)
map("n", "<M-Down>", ":m .+1<cr>==", opts)
map("n", "<M-Up>", ":m .-2<cr>==", opts)
map("v", "<M-Down>", ":m '>+1<cr>gv=gv", opts)
map("v", "<M-Up>", ":m '<-2<cr>gv=gv", opts)
-- make y copy
map("n", "Y", "y$", opts)

-- undo break point
map("i", ",", ",<C-g>u", opts)
map("i", ".", ".<C-g>u", opts)
map("i", "!", "!<C-g>u", opts)
map("i", "?", "?<C-g>u", opts)
map("i", "[", "[<C-g>u", opts)
map("i", " ", " <C-g>u", opts)

-- don't lose indent with esc
map("i", "<esc>", "x<bs><esc>", opts)
map("i", "<cr>", "<cr>x<bs>", opts)
map("n", "o", "ox<bs>", opts)
map("n", "O", "Ox<bs>", opts)
map("n", "S", "Sx<bs>", opts)
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
