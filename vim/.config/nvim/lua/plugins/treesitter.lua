return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- event = "BufReadPost",
		config = function()
			-- require("nvim-treesitter.install").compilers = { "clang" }
			require("nvim-treesitter.configs").setup({
				ignore_install = {},
				indent = { enable = false },
				-- highlight = { enable = true, additional_vim_regex_highlighting = { "markdown" } },
				highlight = { enable = true, disable = { "yaml" } },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ia"] = "@parameter.inner", -- a for argument
							["aa"] = "@parameter.outer",
							["ii"] = "@conditional.inner",
							["ai"] = "@conditional.outer",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]l"] = "@loop.outer",
							["]a"] = "@parameter.outer",
							["]i"] = "@conditional.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]L"] = "@loop.outer",
							["]A"] = "@parameter.outer",
							["]I"] = "@conditional.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[l"] = "@loop.outer",
							["[a"] = "@parameter.outer",
							["[i"] = "@conditional.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[L"] = "@loop.outer",
							["[A"] = "@parameter.outer",
							["[I"] = "@conditional.outer",
						},
					},
				},
				matchup = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<cr>",
						node_incremental = "<cr>",
						node_decremental = "<bs>",
					},
				},
			})

			vim.api.nvim_command(
				"au Filetype javascriptreact,typescriptreact,html setlocal indentexpr=nvim_treesitter#indent()"
			)
		end,
	},
	"nvim-treesitter/nvim-treesitter-textobjects",
	"windwp/nvim-ts-autotag",
	{
		"s1n7ax/nvim-comment-frame",
		opts = {
			keymap = "cm",
			multiline_keymap = "cm",
		},
	},
	{
		"hiphish/rainbow-delimiters.nvim",
		config = function()
			-- local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				-- strategy = {
				-- 	[""] = rainbow_delimiters.strategy["global"],
				-- 	-- vim = rainbow_delimiters.strategy["local"],
				-- },
				query = {
					-- [""] = "rainbow-delimiters",
					tsx = "rainbow-parens",
					-- lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterOrange",
					"RainbowDelimiterPink",
					"RainbowDelimiterBlue",
					"RainbowDelimiterGrey",
					"RainbowDelimiterCyan",
					"RainbowDelimiterRed",
				},
			}
			vim.cmd([[
				hi RainbowDelimiterOrange guifg=#ebcb8b
				hi RainbowDelimiterPink guifg=#f199ce
				hi RainbowDelimiterBlue guifg=#569cd6
				hi RainbowDelimiterGrey guifg=#a3c4ef
				hi RainbowDelimiterCyan guifg=#acebfb
				hi RainbowDelimiterRed guifg=#ee766d
			]])
		end,
	},
}
