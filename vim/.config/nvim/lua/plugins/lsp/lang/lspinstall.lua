local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local config = require("plugins.lsp.config").config()
	if server.name == "sumneko_lua" then
		config.settings.Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		}
		-- elseif server.name == "hls" then
		-- 	config.settings.haskell = {
		-- 		formattingProvider = "ormolu",

		-- 		-- hlint = { globalOn = true },
		-- 	}
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
