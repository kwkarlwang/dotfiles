local null_ls = require("null-ls")
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
			"-",
		},
		to_stdin = true,
	},
	factory = h.formatter_factory,
})

local builtins = null_ls.builtins
local sources = {
	----------------------------------------------------------------------
	--                               lua                                --
	----------------------------------------------------------------------
	builtins.formatting.stylua,
	----------------------------------------------------------------------
	--                              python                              --
	----------------------------------------------------------------------
	-- builtins.formatting.black,
	builtins.formatting.yapf,
	builtins.formatting.reorder_python_imports,
	-- builtins.diagnostics.mypy,
	----------------------------------------------------------------------
	--                               rust                               --
	----------------------------------------------------------------------
	builtins.formatting.rustfmt,
	----------------------------------------------------------------------
	--                               c++                                --
	----------------------------------------------------------------------
	-- builtins.formatting.clang_format,
	builtins.formatting.cmake_format,
	----------------------------------------------------------------------
	--                            typescript                            --
	----------------------------------------------------------------------
	builtins.formatting.prettierd,
	-- builtins.diagnostics.eslint_d,
	-- builtins.code_actions.eslint_d,
	-- builtins.formatting.prettier,
	-- builtins.diagnostics.eslint,
	-- builtins.code_actions.eslint,
	-- builtins.formatting.stylelint,
	-- builtins.diagnostics.stylelint,
	----------------------------------------------------------------------
	--                              proto                               --
	----------------------------------------------------------------------
	builtins.formatting.protolint,
	builtins.diagnostics.protolint,
	----------------------------------------------------------------------
	--                              other                               --
	----------------------------------------------------------------------
	haskellfmt,
	latexfmt,
	systemverilogfmt,
	builtins.formatting.shfmt,
}
null_ls.setup({
	diagnostics_format = "#{s}: #{m}",
	sources = sources,
})
