local on_attach = function(client, bufnr)
	local function bufmap(...)
		api.nvim_buf_set_keymap(bufnr, ...)
	end

	bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", NS)
	bufmap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float({ show_header=false })<cr>", NS)
	bufmap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev()<cr>", NS)
	bufmap("n", "]e", "<cmd>lua vim.diagnostic.goto_next()<cr>", NS)

	bufmap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", NS)
	bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", NS)
	bufmap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", NS)
	bufmap("n", "gD", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", NS)
	bufmap("n", "<leader>lD", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", NS)
	bufmap("n", "<leader>ld", "<cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<cr>", NS)
	bufmap("n", "<leader>lS", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", NS)
	bufmap("n", "<leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", NS)
	bufmap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<cr>", NS)
	bufmap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", NS)
	bufmap("n", "<leader>lr", "<cmd>LspRestart<cr>", NS)

	client.server_capabilities.documentFormattingProvider = false
	-- disable semantic highlight
	-- client.server_capabilities.semanticTokensProvider = nil
end

local config = function()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local config = {
		capabilities = capabilities,
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 200,
		},
		-- make the lsp start at cwd instead of git dir
		root_dir = vim.loop.cwd,
		settings = {
			rootMakers = { "" },
		},
	}
	return config
end
return { on_attach = on_attach, config = config }
