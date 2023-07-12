local on_attach = function(client, bufnr)
	---
	---@param mode string
	---@param lhs string
	---@param rhs function | string
	local function bufmap(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
	end

	bufmap("n", "K", vim.lsp.buf.hover)
	bufmap("n", "<space>e", function()
		vim.diagnostic.open_float({ show_header = false })
	end)
	bufmap("n", "[e", vim.diagnostic.goto_prev)
	bufmap("n", "]e", vim.diagnostic.goto_next)

	bufmap("n", "gi", vim.lsp.buf.implementation)
	bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
	bufmap("n", "gd", vim.lsp.buf.definition)
	bufmap("n", "gt", vim.lsp.buf.type_definition)
	bufmap("n", "gD", vim.lsp.buf.references)
	bufmap("n", "<leader>lD", require("telescope.builtin").diagnostics)
	bufmap("n", "<leader>ld", function()
		require("telescope.builtin").diagnostics({ bufnr = 0 })
	end)
	bufmap("n", "<leader>lS", require("telescope.builtin").lsp_workspace_symbols)
	bufmap("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols)
	bufmap("n", "<leader>cf", vim.lsp.buf.formatting)
	bufmap("n", "<leader>cr", vim.lsp.buf.rename)
	bufmap("n", "<leader>lr", "<cmd>LspRestart<cr>")

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
