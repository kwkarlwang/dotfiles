-- common plugins for both kitty-scrollback and nvim
return {
	-- theme
	{
		"dracula/vim",
		name = "dracula",
		init = function()
			g.dracula_full_special_attrs_support = 1
		end,
		config = function()
			--- @param name string
			--- @param color table<string, any> color
			local set_color = function(name, color)
				vim.api.nvim_set_hl(0, name, color)
			end
			local colors = require("extensions.colors")
			vim.g["dracula#palette"] = vim.tbl_deep_extend("force", vim.g["dracula#palette"], colors)
			vim.cmd("colorscheme dracula")
			set_color("CursorLine", { bg = colors.subtledark[1] })
			set_color("DraculaWinSeparator", { fg = colors.comment[1] })
			set_color("CursorLineNr", { link = "DraculaFg" })
			-- git related
			set_color("DiffAdd", { link = "DraculaDiffAdd" })
			set_color("DraculaDiffAdd", { bg = colors.diffadd[1] })
			set_color("DraculaDiffChange", { bg = colors.diffchange[1] })
			set_color("DraculaDiffText", { bg = colors.difftext[1] })
			set_color("DraculaDiffDelete", { bg = colors.diffdelete[1] })

			set_color("DraculaDiffAddSign", { fg = colors.green[1] })
			set_color("DraculaDiffChangeSign", { fg = colors.orange[1] })
			set_color("DraculaDiffTextSign", { fg = colors.bg[1] })
			set_color("DraculaDiffDeleteSign", { fg = colors.red[1] })

			-- gitsigns
			set_color("GitSignsAdd", { link = "DraculaDiffAddSign" })
			set_color("GitSignsAddLn", { link = "DraculaGreen" })
			set_color("GitSignsAddNr", { link = "DraculaDiffAddSign" })
			set_color("GitSignsChange", { link = "DraculaDiffChangeSign" })
			set_color("GitSignsChangeLn", { link = "DraculaOrange" })
			set_color("GitSignsChangeNr", { link = "DraculaDiffChangeSign" })
			set_color("GitSignsDelete", { link = "DraculaDiffDeleteSign" })
			set_color("GitSignsDeleteLn", { link = "DraculaRed" })
			set_color("GitSignsDeleteNr", { link = "DraculaDiffDeleteSign" })
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
