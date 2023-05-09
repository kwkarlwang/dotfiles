local lspconfig = require("lspconfig")

local ignore_list = { "jdtls", "hls" }

require("mason-lspconfig").setup_handlers({
	function(server_name)
		if vim.tbl_contains(ignore_list, server_name) then
			return
		end
		local config = require("plugins.lsp.config").config()
		if server_name == "sumneko_lua" then
			config.settings.Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			}
		elseif server_name == "clangd" then
			config.capabilities = require("cmp_nvim_insert_text_lsp").default_capabilities()
			config.cmd = {
				"clangd",
				"--background-index",
				"--suggest-missing-includes",
				"--clang-tidy",
				"--fallback-style=Google",
				"--header-insertion=never",
				"--completion-style=bundled",
				"--enable-config",
			}
			config.on_attach = function(client, bufnr)
				require("plugins.lsp.config").on_attach(client, bufnr)
				client.server_capabilities.documentFormattingProvider = true
			end
		elseif server_name == "tsserver" or server_name == "eslint" then
			config.root_dir = lspconfig.util.root_pattern("node_modules") or vim.loop.cwd()
		end
		lspconfig[server_name].setup(config)
	end,
})
