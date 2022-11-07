local lsp_config = require("lspconfig")

local ignore_list = { "jdtls" }

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
			-- config.capabilities.offsetEncoding = { "utf-16" }
			-- do not automatically insert ()
			-- config.capabilities.textDocument.completion.snippetSupport = false
			-- config.cmd = {
			-- 	"clangd",
			-- 	"--background-index",
			-- 	"--suggest-missing-includes",
			-- 	"--clang-tidy",
			-- 	"--fallback-style=Google",
			-- 	"--header-insertion=never",
			-- 	"--completion-style=bundled",
			-- 	"--enable-config",
			-- }
			config.on_attach = function(client, bufnr)
				require("plugins.lsp.config").on_attach(client, bufnr)
				client.server_capabilities.documentFormattingProvider = true
			end
		end
		lsp_config[server_name].setup(config)
	end,
})

local config = require("plugins.lsp.config").config()
lsp_config.hls.setup(config)
