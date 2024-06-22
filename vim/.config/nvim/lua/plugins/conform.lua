return {
	"stevearc/conform.nvim",
	lazy = true,
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "v" },
		},
		{
			"ss",
			function()
				require("conform").format({ async = true }, function()
					vim.cmd("silent noautocmd update")
				end)
			end,
			mode = { "n", "v" },
		},
	},
	opts = {
		format = {
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			python = { "black", "isort" },
			bzl = { "buildifier" },
			sql = { "sql_formatter" },
			java = { "google-java-format" },
			proto = { "buf" },
			toml = { "taplo" },
		},
		formatters = {
			injected = { options = { ignore_errors = true } },
			sql_formatter = {
				prepend_args = { "--language", "spark" },
			},
		},
	},
}
