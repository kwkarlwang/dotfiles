local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local FORMATTING = methods.internal.FORMATTING

local haskellfmt = h.make_builtin({
	method = FORMATTING,
	filetypes = { "haskell" },
	generator_opts = {
		command = "ormolu",
		to_stdin = true,
	},
	factory = h.formatter_factory,
})

local latexfmt = h.make_builtin({
	method = FORMATTING,
	filetypes = { "tex" },
	generator_opts = {
		command = "latexindent",
		to_stdin = true,
	},
	factory = h.formatter_factory,
})

local systemverilogfmt = h.make_builtin({
	method = FORMATTING,
	filetypes = { "systemverilog" },
	generator_opts = {
		command = "verible-verilog-format",
		args = {
			"$FILENAME",
		},
		to_stdin = true,
	},
	factory = h.formatter_factory,
})

local null_ls = require("null-ls")
local builtins = null_ls.builtins
local sources = {
	builtins.formatting.stylua,
	builtins.formatting.black,
	builtins.formatting.rustfmt,
	builtins.formatting.clang_format,
	haskellfmt,
	latexfmt,
	systemverilogfmt,
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
