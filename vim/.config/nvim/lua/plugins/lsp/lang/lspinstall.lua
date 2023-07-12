local lspconfig = require("lspconfig")

local ignore_list = { "jdtls", "hls", "rust_analyzer" }

local use_lsp_formatting = { "clangd", "gopls" }

require("mason-lspconfig").setup_handlers({
	---@param server_name string
	function(server_name)
		if vim.tbl_contains(ignore_list, server_name) then
			return
		end
		local config = require("plugins.lsp.config").config()
		if server_name == "lua_ls" then
			require("neodev").setup({})
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
		elseif server_name == "eslint" then
			config.root_dir = lspconfig.util.root_pattern("node_modules") or vim.loop.cwd()
			config.on_attach = function() end
		elseif server_name == "vtsls" then
			require("lspconfig.configs").vtsls = require("vtsls").lspconfig
			local on_attach = config.on_attach
			config.on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				vim.keymap.set("n", "ss", function()
					local current_buf = vim.api.nvim_get_current_buf()
					require("vtsls").commands.add_missing_imports(current_buf, function()
						require("vtsls").commands.organize_imports(current_buf, function()
							vim.api.nvim_command("silent noautocmd update")
							AsyncFormat(current_buf)
						end)
					end)
				end, { buffer = bufnr })
			end
			-- filter react index.d.ts, make telescope go to definition
			-- https://github.com/typescript-language-server/typescript-language-server/issues/216
			local function filterReactDTS(value)
				return string.match(value.targetUri, "react/index.d.ts") == nil
			end
			config.handlers = {
				["textDocument/definition"] = function(err, result, method, ...)
					if vim.tbl_islist(result) and #result > 1 then
						result = vim.tbl_filter(filterReactDTS, result)
					end
					return vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
				end,
			}
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
