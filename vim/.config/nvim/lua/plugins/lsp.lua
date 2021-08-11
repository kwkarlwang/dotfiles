--------LSP-----------
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function bufmap(...)
    api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  bufmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", NS)
  --bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- bufmap("n", "<space>wA", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", NS)
  -- bufmap("n", "<space>wR", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", NS)
  -- bufmap("n", "<space>wL", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", NS)
  --bufmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bufmap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", NS)
  bufmap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header=false })<CR>", NS)
  bufmap("n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", NS)
  bufmap("n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", NS)
  --bufmap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --bufmap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- LSP RELATED
  bufmap("n", "gi", "<cmd>Telescope lsp_implementation<CR>", NS)
  bufmap("n", "<space>ca", "<cmd>Telescope lsp_code_actions<CR>", NS)
  bufmap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", NS)
  bufmap("n", "gD", "<cmd>Telescope lsp_references<CR>", NS)
  bufmap("n", "<leader>ld", "<cmd>Telescope lsp_workspace_diagnostics<cr>", NS)
  bufmap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", NS)
end

------------- LSP INSTALL
local function setup_servers()
  require "lspinstall".setup()
  local servers = require "lspinstall".installed_servers()
  for _, server in pairs(servers) do
    local config = {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150
      }
      -- make the lsp start at cwd instead of git dir
      -- root_dir = function()
      --   return vim.loop.cwd()
      -- end
    }
    -- if server == "python" then
    --   config["settings"] = {
    --     python = {
    --       analysis = {
    --         autoSearchPaths = false,
    --         useLibraryCodeForTypes = true,
    --         diagnosticMode = "workspace"
    --       }
    --     }
    --   }
    -- end
    require "lspconfig"[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require "lspinstall".post_install_hook = function()
  setup_servers() -- reload installed servers
  cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)"
}

fn.sign_define(
  "LspDiagnosticsSignError",
  {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
fn.sign_define(
  "LspDiagnosticsSignWarning",
  {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
fn.sign_define(
  "LspDiagnosticsSignHint",
  {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)
fn.sign_define(
  "LspDiagnosticsSignInformation",
  {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)
