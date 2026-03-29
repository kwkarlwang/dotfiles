return {
	require("plugins.lightspeed"),
	require("plugins.comment"),
	require("plugins.surround"),
	require("plugins.treesitter"),
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
