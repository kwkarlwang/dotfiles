return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- event = "BufReadPost",
		config = function()
			-- require("nvim-treesitter.install").compilers = { "gcc" }
			require("nvim-treesitter.configs").setup({
				ignore_install = {},
				indent = { enable = false },
				-- highlight = { enable = true, additional_vim_regex_highlighting = { "markdown" } },
				highlight = { enable = true },
				rainbow = {
					enable = true,
					extended_mode = false,
					colors = {
						"#ebcb8b",
						"#f199ce",
						"#569cd6",
						"#a3c4ef",
						"#acebfb",
						"#ee766d",
					},
				},
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
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				matchup = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
			})

			vim.api.nvim_command(
				"au Filetype javascriptreact,typescriptreact,html setlocal indentexpr=nvim_treesitter#indent()"
			)
		end,
	},
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	-- "p00f/nvim-ts-rainbow", -- make color brackets
	"nvim-treesitter/nvim-treesitter-textobjects",
	"windwp/nvim-ts-autotag",
	{
		"s1n7ax/nvim-comment-frame",
		opts = {
			keymap = "cm",
			multiline_keymap = "cm",
		},
	},
	"mrjones2014/nvim-ts-rainbow",
}
