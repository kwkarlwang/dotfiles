local ts_on_attach = function(client, bufnr)
	require("plugins.lsp.config").on_attach(client, bufnr)
	-- disable tsserver formatting if you plan on formatting via null-ls
	local ts_utils = require("nvim-lsp-ts-utils")

	-- defaults
	ts_utils.setup({
		debug = false,
		disable_commands = false,
		enable_import_on_completion = true,

		-- import all
		import_all_timeout = 5000, -- ms
		import_all_priorities = {
			buffers = 4, -- loaded buffer names
			buffer_content = 3, -- loaded buffer content
			local_files = 2, -- git files or files with relative path markers
			same_file = 1, -- add to existing import statement
		},
		import_all_scan_buffers = 100,
		import_all_select_source = true,

		-- eslint
		eslint_enable_code_actions = true,
		eslint_enable_disable_comments = true,
		eslint_bin = "eslint_d",
		eslint_enable_diagnostics = true,
		eslint_opts = {},

		-- formatting
		enable_formatting = true,
		formatter = "prettier",
		formatter_opts = {},

		-- update imports on file move
		update_imports_on_move = true,
		require_confirmation_on_move = false,
		watch_dir = nil,

		-- filter diagnostics
		filter_out_diagnostics_by_severity = {},
		filter_out_diagnostics_by_code = {},
	})

	-- required to fix code action ranges and filter diagnostics
	ts_utils.setup_client(client)

	-- no default maps, so you may want to define some here
	bufmap("n", "gs", ":TSLspOrganize<CR>", NS)
	bufmap("n", "gr", ":TSLspRenameFile<CR>", NS)
	bufmap("n", "gi", ":TSLspImportAll<CR>", NS)
end
local lspconfig = require("lspconfig")
local config = require("plugins.lsp.config").config()
config.on_attach = ts_on_attach
lspconfig.tsserver.setup(config)
