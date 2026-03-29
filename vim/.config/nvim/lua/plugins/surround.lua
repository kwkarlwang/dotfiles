return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			surrounds = {
				["A"] = {
					add = function()
						local ok, am = pcall(require, "extensions.algomonad")
						if not ok then
							return
						end
						local left = am.comment_with_open_identifier()
						local right = am.comment_with_close_identifier()
						return { { left }, { right } }
					end,
				},
			},
		})
	end,
}
