local function setup_servers()
	require("lspinstall").setup()
	local servers = require("lspinstall").installed_servers()
	local lspconfig = require("lspconfig")
	local config = require("plugins.lsp.config").config()
	for _, server in pairs(servers) do
		if server == "lua" then
			local luaconfig = require("plugins.lsp.config").config()
			luaconfig.settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			}
			lspconfig[server].setup(luaconfig)
		elseif server ~= "typescript" then
			lspconfig[server].setup(config)
		end
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
	setup_servers() -- reload installed servers
	cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
