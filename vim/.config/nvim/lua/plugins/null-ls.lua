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

local groovyfmt = h.make_builtin({
	method = FORMATTING,
	filetypes = { "groovy" },
	generator_opts = {
		command = "npm-groovy-lint",
		args = {
			"--noserver",
			"--format",
			"--files",
			"$DIRNAME/*.gradle",
		},
		to_temp_file = true,
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
	-- builtins.formatting.reorder_python_imports,
	builtins.formatting.yapf,
	-- builtins.diagnostics.mypy,
	----------------------------------------------------------------------
	--                               java                               --
	----------------------------------------------------------------------
	builtins.formatting.google_java_format,
	----------------------------------------------------------------------
	--                               rust                               --
	----------------------------------------------------------------------
	builtins.formatting.rustfmt,
	----------------------------------------------------------------------
	--                               c++                                --
	----------------------------------------------------------------------
	builtins.formatting.cmake_format,
	----------------------------------------------------------------------
	--                            typescript                            --
	----------------------------------------------------------------------
	builtins.formatting.prettier,
	-- builtins.diagnostics.eslint_d,
	-- builtins.code_actions.eslint_d,
	-- builtins.formatting.prettier,
	-- builtins.diagnostics.eslint,
	-- builtins.code_actions.eslint,
	-- builtins.formatting.stylelint,
	-- builtins.diagnostics.stylelint,
	----------------------------------------------------------------------
	--                                go                                --
	----------------------------------------------------------------------
	builtins.formatting.gofmt,
	builtins.formatting.goimports,
	----------------------------------------------------------------------
	--                              proto                               --
	----------------------------------------------------------------------
	builtins.formatting.clang_format.with({
		filetypes = { "proto" },
	}),
	builtins.diagnostics.protolint,
	----------------------------------------------------------------------
	--                               sql                                --
	----------------------------------------------------------------------
	builtins.formatting.pg_format,
	----------------------------------------------------------------------
	--                               json                               --
	----------------------------------------------------------------------
	builtins.diagnostics.jsonlint,
	----------------------------------------------------------------------
	--                              other                               --
	----------------------------------------------------------------------
	haskellfmt,
	latexfmt,
	systemverilogfmt,
	builtins.formatting.shfmt,
	-- groovyfmt,
}
null_ls.setup({
	diagnostics_format = "#{s}: #{m}",
	sources = sources,
	-- debug = true,
})

AsyncFormat = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	vim.lsp.buf_request(
		bufnr,
		"textDocument/formatting",
		{ textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
		function(err, res, ctx)
			if err then
				local err_msg = type(err) == "string" and err or err.message
				-- you can modify the log message / level (or ignore it completely)
				vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
				return
			end

			-- don't apply results if buffer is unloaded or has been modified
			if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
				return
			end

			if res then
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("silent noautocmd update")
				end)
			end
		end
	)
end
