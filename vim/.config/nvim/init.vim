call plug#begin('~/.config/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'junegunn/fzf'
"Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdcommenter'
call plug#end()

let mapleader = "\<Space>"

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <leader>h gT
nnoremap <silent> <leader>l gt
nnoremap <silent><Esc> :noh<CR>
nnoremap <silent> <leader><space> :FZF<CR>
vnoremap <silent>< <gv
vnoremap <silent>> >gv
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <silent><leader>op :NERDTreeToggle<CR>

let g:dracula_italic = 1
let g:dracula_underline = 1
let g:dracula_colorterm = 1
syntax enable " Syntax highlighting
set background=dark
colorscheme dracula
set termguicolors
set relativenumber " Line numbers
set autoindent " Auto indenting
set smartindent
set incsearch " search as characters are entered
set hlsearch " highlight matches
set backspace=indent,eol,start
filetype indent on
set showcmd
set scrolloff=3
"hi Normal guibg=NONE ctermbg=NONE
"hi Normal guifg=#FFFACD	ctermbg=NONE
"hi Comment guifg=#c4acf5
set guifont=Menlo\ Regular:h15
"let g:python_highlight_all = 1
set t_Co=256
set timeoutlen=1000 ttimeoutlen=10
"let g:auto_save = 1
