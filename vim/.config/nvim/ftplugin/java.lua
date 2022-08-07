local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local home_dir = os.getenv("HOME") .. "/"

local workspace_dir = home_dir .. "workspace/" .. project_name

local os_mapping = function()
	if vim.loop.os_uname().sysname == "Darwin" then
		return "mac"
	end
	return "linux"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		vim.fn.glob(home_dir .. ".local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

		-- 💀
		"-configuration",
		home_dir .. ".local/share/nvim/mason/packages/jdtls/config_" .. os_mapping(),
		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
	on_attach = function(client, bufnr)
		require("jdtls.setup").add_commands()
		require("plugins.lsp.config").on_attach(client, bufnr)
		vim.keymap.set("n", "<leader>lu", jdtls.update_project_config)
		vim.keymap.set("n", "<leader>oi", jdtls.organize_imports)

		vim.keymap.set("n", "<leader>gm", jdtls.extract_method)
		vim.keymap.set("v", "<leader>gm", function()
			jdtls.extract_method(true)
		end)
		vim.keymap.set("n", "<leader>gc", jdtls.extract_constant)
		vim.keymap.set("v", "<leader>gc", function()
			jdtls.extract_constant(true)
		end)
		vim.keymap.set("n", "<leader>gv", jdtls.extract_variable)
		vim.keymap.set("v", "<leader>gv", function()
			jdtls.extract_variable(true)
		end)
	end,
	capabilities = capabilities,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
