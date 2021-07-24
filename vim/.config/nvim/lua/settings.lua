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
o.showcmd = true
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

--o.signcolumn = 'yes'
--o.colorcolumn = 110
cmd "set signcolumn=yes"
--cmd 'set colorcolumn=110'

o.clipboard = "unnamedplus"
o.cursorline = true

-- not working
cmd "autocmd! BufEnter * set fo-=r fo-=o"

--------Theme-----------
cmd "colorscheme dracula"
g.dracula_italic = true
g.dracula_underline = true
g.dracula_colorterm = true

--------Status line-----------
cmd "set noshowmode"
g.ruler = false
g.laststatus = 0
cmd "set noshowcmd"

--------Disable 'pattern not found'-----------
cmd "set shortmess+=c"

--------Set splitting-----------
o.splitbelow = true
o.splitright = true

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
