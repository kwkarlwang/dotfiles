local ht = require("haskell-tools")
local def_opts = { noremap = true, silent = true }
ht.start_or_attach({
	tools = {
		codeLens = {
			autoRefresh = true,
		},
		hover = {
			disable = true,
		},
	},
	hls = {
		on_attach = function(client, bufnr)
			require("plugins.lsp.config").on_attach(client, bufnr)
			local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
			-- haskell-language-server relies heavily on codeLenses,
			-- so auto-refresh (see advanced configuration) is enabled by default
			vim.keymap.set("n", "<space>rr", vim.lsp.codelens.run, opts)
			vim.keymap.set("n", "<space>ho", ht.hoogle.hoogle_signature, opts)
			vim.keymap.set("n", "<space>ra", ht.lsp.buf_eval_all, opts)
		end,
	},
})

-- Suggested keymaps that do not depend on haskell-language-server:
local bufnr = vim.api.nvim_get_current_buf()
-- set buffer = bufnr in ftplugin/haskell.lua
local opts = { noremap = true, silent = true, buffer = bufnr }

-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<leader>rt", ht.repl.toggle, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>rf", function()
	ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts)

-- Detect nvim-dap launch configurations
-- (requires nvim-dap and haskell-debug-adapter)
ht.dap.discover_configurations(bufnr)
