call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'junegunn/fzf'
call plug#end()

let g:dracula_italic = 0
let g:dracula_underline = 1
let g:dracula_colorterm = 1
syntax enable " Syntax highlighting
set background=dark
colorscheme dracula
set termguicolors
set number " Line numbers
set autoindent " Auto indenting
set incsearch " search as characters are entered
set hlsearch "highlight matches
set backspace=indent,eol,start
filetype indent on
set showcmd
set scrolloff=3
"#hi Normal guibg=NONE ctermbg=NONE
hi Normal guifg=#FFFACD	ctermbg=NONE
hi Comment guifg=#c4acf5
set guifont=Menlo\ Regular:h15
let g:python_highlight_all = 1

