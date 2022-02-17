local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local config = require("plugins.lsp.config").config()
	if server.name == "sumneko_lua" then
		config.settings.Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		}
	elseif server.name == "clangd" then
		config.capabilities.offsetEncoding = { "utf-16" }
		-- do not automatically insert ()
		config.capabilities.textDocument.completion.completionItem.snippetSupport = false
		config.cmd = {
			"clangd",
			"--all-scopes-completion",
			"--background-index",
			"--clang-tidy",
			"--fallback-style=Google",
			"--pch-storage=memory",
			"--header-insertion=iwyu",
			"--completion-style=bundled",
			"--enable-config",
			"--header-insertion-decorators",
		}
		config.on_attach = function(client, bufnr)
			require("plugins.lsp.config").on_attach(client, bufnr)
			client.resolved_capabilities.document_formatting = true
			client.resolved_capabilities.document_range_formatting = true
		end
	elseif server.name == "tsserver" then
		config.on_attach = function(client, bufnr)
			local function bufmap(...)
				api.nvim_buf_set_keymap(bufnr, ...)
			end
			require("plugins.lsp.config").on_attach(client, bufnr)
			bufmap("n", "go", ":lua require('nvim-lsp-installer.extras.tsserver').organize_imports()<CR>", NS)
		end
	end
	server:setup(config)
	vim.cmd([[ do User LspAttachBuffers ]])
end)