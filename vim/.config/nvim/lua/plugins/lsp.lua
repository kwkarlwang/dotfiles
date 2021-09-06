--------LSP-----------
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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
	bufmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<cr>", NS)
	bufmap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", NS)
	bufmap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header=false })<cr>", NS)
	bufmap("n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", NS)
	bufmap("n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", NS)

	-- LSP RELATED
	bufmap("n", "gi", "<cmd>Telescope lsp_implementation<cr>", NS)
	bufmap("n", "<space>ca", "<cmd>Telescope lsp_code_actions<cr>", NS)
	bufmap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", NS)
	bufmap("n", "gD", "<cmd>Telescope lsp_references<cr>", NS)
	bufmap("n", "<leader>ld", "<cmd>Telescope lsp_workspace_diagnostics<cr>", NS)
	bufmap("n", "<leader>lD", "<cmd>Telescope lsp_document_diagnostics<cr>", NS)
	bufmap("n", "<leader>ls", "<cmd>Telescope lsp_workspace_symbols<cr>", NS)
	bufmap("n", "<leader>lS", "<cmd>Telescope lsp_document_symbols<cr>", NS)
	bufmap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<cr>", NS)

	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

local if_nil = function(val, default)
	if val == nil then
		return default
	end
	return val
end

local update_capabilities = function(capabilities, override)
	override = override or {}

	local completionItem = capabilities.textDocument.completion.completionItem

	completionItem.snippetSupport = if_nil(override.snippetSupport, true)
	completionItem.preselectSupport = if_nil(override.preselectSupport, true)
	completionItem.insertReplaceSupport = if_nil(override.insertReplaceSupport, true)
	completionItem.labelDetailsSupport = if_nil(override.labelDetailsSupport, true)
	completionItem.deprecatedSupport = if_nil(override.deprecatedSupport, true)
	completionItem.commitCharactersSupport = if_nil(override.commitCharactersSupport, true)
	completionItem.tagSupport = if_nil(override.tagSupport, { valueSet = { 1 } })
	completionItem.resolveSupport = if_nil(override.resolveSupport, {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	})

	return capabilities
end

------------- LSP INSTALL
local function setup_servers()
	require("lspinstall").setup()
	local servers = require("lspinstall").installed_servers()

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	update_capabilities(capabilities)

	for _, server in pairs(servers) do
		local config = {
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 150,
			},
			-- make the lsp start at cwd instead of git dir
			root_dir = function()
				return vim.loop.cwd()
			end,
		}
		require("lspconfig")[server].setup(config)
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
	setup_servers() -- reload installed servers
	cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

fn.sign_define(
	"LspDiagnosticsSignError",
	{ texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
)
fn.sign_define(
	"LspDiagnosticsSignWarning",
	{ texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" }
)
fn.sign_define(
	"LspDiagnosticsSignHint",
	{ texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" }
)
fn.sign_define(
	"LspDiagnosticsSignInformation",
	{ texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" }
)

-- update in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	update_in_insert = true,
	virtual_text = true,
})
