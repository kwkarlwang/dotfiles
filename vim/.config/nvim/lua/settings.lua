--------Globals-----------
g.mapleader = " "

--------Options-----------
o.mouse = "a"
o.number = true
o.relativenumber = true
o.scrolloff = 3
o.background = "dark"
o.termguicolors = true
o.autoindent = true
o.incsearch = true
o.hlsearch = true
o.backspace = "indent,eol,start"
o.showcmd = false
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
--cmd 'set hidden'
o.hidden = true

o.smartcase = true
o.ignorecase = true

cmd "set noswapfile"
cmd "set nobackup"
cmd "set undodir=~/.vim/undodir"
o.undofile = true

cmd "set signcolumn=yes"

o.clipboard = "unnamedplus"
o.cursorline = true

-- not working
cmd "autocmd! BufEnter * set fo-=r fo-=o"

--------Status line-----------
o.showmode = false
g.ruler = false
g.laststatus = 0

--------Disable 'pattern not found'-----------
cmd "set shortmess+=c"

--------Set splitting-----------
o.splitbelow = true
o.splitright = true

--------Auto revert-----------
o.autoread = true
cmd [[
     " trigger `autoread` when files changes on disk
      autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " notification after file change
      autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]]

--------Netrw mapping-----------
--cmd [[
--function! NetrwMapping()
--nnoremap <buffer>h -^
--nnoremap <buffer>l <CR>

--nnoremap <buffer>. gh
--nnoremap <buffer>P <C-w>z

--nnoremap <buffer><silent>q :bw<CR>
--nnoremap <buffer><silent><esc> :bw<CR>
--endfunction

--augroup netrw_mapping
--autocmd!
--autocmd filetype netrw call NetrwMapping()
--augroup END
--]]
