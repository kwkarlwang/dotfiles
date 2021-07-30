--------Globals-----------
g.mapleader = " "

--------Options-----------
o.mouse = "a"
o.number = true
o.relativenumber = true
o.scrolloff = 8
o.sidescrolloff = 8
o.background = "dark"
o.termguicolors = true
o.incsearch = true
o.hlsearch = true
o.backspace = "indent,eol,start"
o.showcmd = false
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
-- o.smartindent = true
o.cindent = true
o.hidden = true

o.smartcase = true
o.ignorecase = true

o.swapfile = false
o.backup = false
o.completeopt = "menuone,noselect"
cmd "set undodir=~/.vim/undodir"
-- o.undodir = "~/.vim/undodir"
o.undofile = true

o.signcolumn = "yes"

o.clipboard = "unnamedplus"
o.cursorline = true

o.signcolumn = "yes"
o.numberwidth = 2
o.wrap = true
o.spell = false

cmd "autocmd! BufEnter * set fo-=r fo-=o"

--------Status line-----------
o.showmode = false
g.ruler = false
g.laststatus = 0

--------Disable 'pattern not found'-----------
o.shortmess:append "c"

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

--------Terminal-----------
cmd "autocmd TermOpen * setlocal nonumber norelativenumber"

--------Auto Resize-----------
-- cmd "autocmd VimResized * wincmd ="

--------Menu Height-----------
o.pumheight = 10

--------Keyboard waiting time-----------
o.timeoutlen = 300
