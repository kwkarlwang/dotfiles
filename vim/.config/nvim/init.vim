call plug#begin('~/.config/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'preservim/nerdcommenter'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()



" Keybindings
let mapleader = " "

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <leader>h gT
nnoremap <silent> <leader>l gt
nnoremap <silent> <Esc> :noh<CR>
nnoremap <silent> <leader><space> :FZF<CR>
vnoremap <silent> < <gv
vnoremap <silent> > >gv
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <silent> <leader>op :NERDTreeToggle<CR>

nnoremap <silent> <leader>pi :PlugInstall<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>




" Color scheme
let g:dracula_italic = 1
let g:dracula_underline = 1
let g:dracula_colorterm = 1
syntax enable " Syntax highlighting
set background=dark
colorscheme dracula
set termguicolors

set number relativenumber " Line numbers
set autoindent " Auto indenting

set incsearch " search as characters are entered
set hlsearch " highlight matches
set backspace=indent,eol,start

filetype indent on
set showcmd
set scrolloff=3
set t_Co=256
set timeoutlen=1000 ttimeoutlen=10

" make tab better
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set exrc
" keep buffer editing in the background
set hidden

set noerrorbells

" case insensitive when lowercase, sensitive when uppercase
set smartcase
set ignorecase

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" make somespace for left side for error
set signcolumn=yes
set colorcolumn=110

set mouse=a

set clipboard+=unnamedplus



lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
