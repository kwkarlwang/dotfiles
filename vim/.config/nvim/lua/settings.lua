--------Disable list-----------
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end
o.shadafile = ""
--------Globals-----------
g.mapleader = " "

--------Options-----------
o.mouse = "a"
-- o.number = true
-- o.relativenumber = true
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
o.cindent = true

o.smartcase = true
o.ignorecase = true

o.swapfile = false
o.backup = false
o.completeopt = "menuone,noselect"
vim.cmd("set undodir=~/.vim/undodir")
o.undofile = true

o.signcolumn = "yes"

o.clipboard = "unnamedplus"
o.cursorline = true

o.signcolumn = "yes"
o.numberwidth = 2
o.wrap = true
o.spell = false
o.spelllang = { "en_us" }

vim.cmd("autocmd! BufEnter * set fo-=r fo-=o")

--------Status line-----------
o.showmode = false
g.ruler = false
g.laststatus = 0

--------Disable 'pattern not found'-----------
o.shortmess:append("c")

--------Set splitting-----------
o.splitbelow = true
o.splitright = true

--------Auto revert-----------
o.autoread = true
vim.cmd([[
     " trigger `autoread` when files changes on disk
      autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
     " notification after file change
      autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | edit | TSBufEnable highlight | echohl None
]])

--------Terminal-----------
vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber")

--------Auto Resize-----------
-- cmd("autocmd VimResized * wincmd =")

--------Menu Height-----------
o.pumheight = 10

--------Keyboard waiting time-----------
o.timeoutlen = 400

--------Turn off scan search-----------
-- o.wrapscan = false

--------Fold-----------
-- startup fold
o.foldenable = false
o.foldmethod = "expr"
o.foldlevel = 20
o.foldexpr = "nvim_treesitter#foldexpr()"

--------Kitty-----------
vim.cmd("let &t_ut=''")

--------disable cursor in inactvie pane-----------
-- local canSetCursorline = true

-- vim.cmd([[
-- augroup CursorLine
--   autocmd!
--   autocmd BufEnter,WinEnter * setlocal cursorline
--   autocmd BufLeave,WinLeave * setlocal nocursorline
--   " autocmd FileType TelescopePrompt setlocal nocursorline
--   " autocmd FileType TelescopePrompt autocmd BufLeave <buffer> echom 'leaving'
-- augroup END
-- ]])
require("plugins.cursorline").setup()

-- for auto-sessions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winpos,terminal"

-- Change file type
vim.cmd([[
augroup FiletypeChange
  autocmd!
  autocmd BufNewFile,BufRead *.xml setf html
  autocmd BufNewFile,BufRead *.launch setf html
augroup END
]])

-- slash diff instead of '-'
o.fillchars:append("diff:╱")
