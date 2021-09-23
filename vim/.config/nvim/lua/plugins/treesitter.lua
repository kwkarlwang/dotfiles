require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	ignore_install = {},
	indent = {
		enable = false,
		disable = { "python", "rust", "tex" },
	},
	highlight = { enable = true },
	rainbow = {
		enable = true,
		extended_modes = false,
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
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
				["]l"] = "@loop.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]C"] = "@class.outer",
				["]L"] = "@loop.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
				["[l"] = "@loop.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[C"] = "@class.outer",
				["[L"] = "@loop.outer",
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
})
