local lspconfig = require("lspconfig")

local ignore_list = { "jdtls", "hls" }

local use_lsp_formatting = { "clangd", "gopls" }

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
		elseif server_name == "tsserver" or server_name == "eslint" then
			config.root_dir = lspconfig.util.root_pattern("node_modules") or vim.loop.cwd()
		elseif server_name == "vtsls" then
			require("lspconfig.configs").vtsls = require("vtsls").lspconfig
			local on_attach = config.on_attach
			config.on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.keymap.set("n", "ss", function()
					local current_buf = vim.api.nvim_get_current_buf()
					require("vtsls").commands.add_missing_imports(current_buf, function()
						require("vtsls").commands.organize_imports(current_buf, function()
							vim.api.nvim_command("write")
							AsyncFormat(current_buf)
						end)
					end)
				end)
				vim.keymap.set("n", "gd", require("vtsls").commands.goto_source_definition)
			end
		elseif server_name == "yamlls" then
			config.settings = {
				redhat = { telemetry = { enabled = false } },
				yaml = { validate = false },
			}
		end

		if vim.tbl_contains(use_lsp_formatting, server_name) then
			local on_attach = config.on_attach
			config.on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				client.server_capabilities.documentFormattingProvider = true
			end
		end

		lspconfig[server_name].setup(config)
	end,
})
