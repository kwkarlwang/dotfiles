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
o.wrap = false
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
      autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
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

--------Kitty-----------
vim.cmd("let &t_ut=''")

--------disable cursor in inactvie pane-----------
require("extensions.cursorline").setup()

-- for auto-sessions
vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winpos,terminal"

-- Change file type
vim.cmd([[
augroup FiletypeChange
  autocmd!
  autocmd BufNewFile,BufRead *.xml setf html
  autocmd BufNewFile,BufRead *.launch setf html
  autocmd BufNewFile,BufRead *.jsonnet.TEMPLATE setf jsonnet
augroup END
]])

-- slash diff instead of '-'
o.fillchars:append("diff:╱")

-- global status line
o.laststatus = 3

-- shiftwidth default to 2
o.shiftwidth = 2

-- hide command prompt
o.cmdheight = 0

-- don't fold by default
o.foldenable = false

-- copy to filepath clipboard
vim.api.nvim_create_user_command("CopyPath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!', vim.log.levels.INFO)
end, {})
