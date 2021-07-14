require "paq" {
  "savq/paq-nvim";                  -- Let Paq manage itself

  "neovim/nvim-lspconfig";          -- Mind the semi-colons
  "hrsh7th/nvim-compe";

  {"dracula/vim", as="dracula"};
  --"neoclide/coc.nvim", {"branch": "release"}
  --"preservim/nerdtree"
  "tpope/vim-sensible";
  "vim-airline/vim-airline";
  "sheerun/vim-polyglot";
  "vim-python/python-syntax";
  "preservim/nerdcommenter";

  -- for telescope
  "nvim-lua/popup.nvim";
  "nvim-lua/plenary.nvim";
  "nvim-telescope/telescope.nvim";

  {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"};

  "tpope/vim-surround";



}


--------Aliases-----------
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map =vim.api.nvim_set_keymap
local o = vim.opt


--------Globals-----------
g.mapleader = ' '

--------Options-----------
o.mouse = 'a'
o.number = true
o.relativenumber = true
o.scrolloff = 3
o.background = 'dark'
o.termguicolors = true
o.autoindent = true
o.incsearch = true
o.hlsearch = true
o.backspace = 'indent,eol,start'
o.showcmd = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.hidden = true

o.smartcase = true
o.ignorecase = true

cmd 'set noswapfile'
cmd 'set nobackup'
o.undodir = '/Users/kwkarlwang/.vim/undodir'
o.undofile = true

--o.signcolumn = 'yes'
--o.colorcolumn = 110
cmd 'set signcolumn=yes'
--cmd 'set colorcolumn=110'



o.clipboard='unnamedplus'

-- not working
cmd 'set formatoptions-=o'

--------Theme-----------
cmd 'colorscheme dracula'
g.dracula_italic = true
g.dracula_underline = true
g.dracula_colorterm = true

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


--------Tree Sitter-----------
require'nvim-treesitter.configs'.setup { highlight = { enable = true } }


--------Telescope-----------
map('n', '<leader><space>','<cmd>Telescope find_files<cr>', {noremap=true})
map('n', '<leader>sp', '<cmd>Telescope live_grep<cr>', {noremap=true})
map('n', '<leader>sp', '<cmd>Telescope grep_string<cr>', {noremap=true})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap=true})


--------LSP-----------
require'lspconfig'.pyright.setup{}
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

--------Completion-----------
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 2;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

map("i", "<CR>", "compe#confirm({ 'keys': '<CR>' })", { expr = true , silent = true})
