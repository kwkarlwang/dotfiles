local lsp_installer = require("nvim-lsp-installer")
local lsp_config = require("lspconfig")

local ignore_list = { "jdtls" }

local installed_servers = vim.tbl_filter(function(server)
	for _, name in ipairs(ignore_list) do
		if name == server.name then
			return false
		end
	end
	return true
end, lsp_installer.get_installed_servers())

for _, server in ipairs(installed_servers) do
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
			client.resolved_capabilities.document_formatting = true
			client.resolved_capabilities.document_range_formatting = true
		end
	elseif server.name == "tsserver" then
		config.on_attach = function(client, bufnr)
			local function bufmap(...)
				api.nvim_buf_set_keymap(bufnr, ...)
			end

			require("plugins.lsp.config").on_attach(client, bufnr)
			bufmap("n", "<leader>oi", ":lua require('nvim-lsp-installer.extras.tsserver').organize_imports()<CR>", NS)
		end
	end
	lsp_config[server.name].setup(config)
end
-- local config = require("plugins.lsp.config").config()
-- lsp_config.hls.setup(config)
