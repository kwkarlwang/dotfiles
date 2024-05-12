-- common plugins for both kitty-scrollback and nvim
return {
	-- theme
	{
		"kwkarlwang/vim-dracula",
		name = "dracula",
		init = function()
			g.dracula_full_special_attrs_support = 1
		end,
		config = function()
			vim.cmd("colorscheme dracula")
		end,
	},
	{
		"rktjmp/highlight-current-n.nvim",
		keys = {
			{ "N", "<Plug>(highlight-current-n-N)zz", silent = true },
			{ "n", "<Plug>(highlight-current-n-n)zz", silent = true },
		},
		config = function()
			vim.cmd([[
				augroup HighlightResult
					autocmd!
					autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
				augroup END
			]])
		end,
	},
}
