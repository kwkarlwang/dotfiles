local on_attach = function(client, bufnr)
	local function bufmap(...)
		api.nvim_buf_set_keymap(bufnr, ...)
	end
	bufmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<cr>", NS)
	bufmap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", NS)
	bufmap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float({ show_header=false })<cr>", NS)
	bufmap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev()<cr>", NS)
	bufmap("n", "]e", "<cmd>lua vim.diagnostic.goto_next()<cr>", NS)

	bufmap("n", "gi", "<cmd>Telescope lsp_implementation<cr>", NS)
	bufmap("n", "<space>ca", "<cmd>Telescope lsp_code_actions<cr>", NS)
	bufmap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", NS)
	bufmap("n", "gD", "<cmd>Telescope lsp_references<cr>", NS)
	bufmap("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", NS)
	bufmap("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<cr>", NS)
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
local config = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	update_capabilities(capabilities)
	local config = {
		capabilities = capabilities,
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 500,
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
