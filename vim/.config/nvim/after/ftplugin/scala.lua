local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
	showImplicitArguments = true,
	enableSemanticHighlighting = true,
	testUserInterface = "Test Explorer",
}
metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
local dap = require("dap")
dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "RunOrTest",
		metals = {
			runType = "runOrTestFile",
			--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "Test Target",
		metals = {
			runType = "testTarget",
		},
	},
}
metals_config.on_attach = function(client, bufnr)
	require("plugins.lsp.config").on_attach(client, bufnr)
	client.server_capabilities.documentFormattingProvider = true
	require("metals").setup_dap()
end
-- vim.cmd([[hi link @property @function]])
vim.opt_global.shortmess:remove("F")
require("metals").initialize_or_attach(metals_config)
