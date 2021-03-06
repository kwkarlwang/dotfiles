--------Mappings-----------
map('n', 'j', 'gj', {noremap=true})
map('n', 'k', 'gk', {noremap=true})
map('n', '<Esc>', ":noh<cr>:echo ''<cr>", {noremap=true, silent=true})
map('v', '<', '<gv', {noremap=true})
map('v', '>', '>gv', {noremap=true})
map('i', 'jk', '<Esc>', {noremap=true})
map('c', '<Down>', 'wildmenumode() ? "<C-n>" : "\\<Down>"', {expr = true, noremap=true})
map('c', '<Up>', 'wildmenumode() ? "<C-p>" : "\\<Up>"', {expr = true, noremap=true})
map('t', '<Esc>', '<C-\\><C-n>', {noremap=true})
-- HELP
map('n', '<leader>hs', ':so %<cr>', {noremap=true, silent=true})
map('n', '<leader>hr', ':so %<cr>:PackerSync<cr>', {noremap=true, silent=true})
-- FILE
map('n', '<leader>fs', ':w<cr>', {noremap=true, silent=true})

-- WINDOWS
map('n', '<leader>ws', ':split<cr>', {noremap=true, silent=true})
map('n', '<leader>wv', ':vsplit<cr>', {noremap=true, silent=true})
map('n', '<leader>wd', '<C-w>c', {noremap=true, silent=true})
-- navigation
map('n', '<leader>wh', '<C-w>h', {noremap=true, silent=true})
map('n', '<leader>wj', '<C-w>j', {noremap=true, silent=true})
map('n', '<leader>wk', '<C-w>k', {noremap=true, silent=true})
map('n', '<leader>wl', '<C-w>l', {noremap=true, silent=true})
