local null_ls = require("null-ls")
local builtins = null_ls.builtins
local sources = {
	builtins.formatting.stylua,
	-- isort is slow
	-- builtins.formatting.isort,
	builtins.formatting.yapf,
	builtins.formatting.rustfmt,
	builtins.formatting.clang_format,
	builtins.formatting.prettier,
	builtins.diagnostics.eslint_d,
	builtins.diagnostics.mypy,
	builtins.code_actions.gitsigns,
}
null_ls.config({
	diagnostics_format = "#{s}: #{m}",
	sources = sources,
})
require("lspconfig")["null-ls"].setup({})
