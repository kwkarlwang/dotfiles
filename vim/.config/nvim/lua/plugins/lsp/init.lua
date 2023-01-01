return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
	},
	config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
		require("plugins.lsp.lang")
		require("plugins.lsp.settings")
	end,
}
