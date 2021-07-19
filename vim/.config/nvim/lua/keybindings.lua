--------Mappings-----------
map('n', 'j', 'gj', {noremap=true})
map('n', 'k', 'gk', {noremap=true})
map('n', '<Esc>', ':noh<CR>', {noremap=true, silent=true})
map('v', '<', '<gv', {noremap=true})
map('v', '>', '>gv', {noremap=true})
map('i', 'jk', '<Esc>', {noremap=true})
map('i', 'jk', '<Esc>', {noremap=true})
map('c', '<Down>', 'wildmenumode() ? "<C-n>" : "\\<Down>"', {expr = true, noremap=true})
map('c', '<Up>', 'wildmenumode() ? "<C-p>" : "\\<Up>"', {expr = true, noremap=true})
map('n', '<leader>hr', ':PackerSync<CR>', {noremap=true, silent=true})
map('t', '<Esc>', '<C-\\><C-n>', {noremap=true})

