return {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local actions = require("telescope.actions")
		local config = {
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-c>"] = false,
					},
				},
				file_ignore_patterns = {
					"node_modules/",
					".git/",
					".gitmodules/",
					"cache",
					"__pycache__/",
					".gradle/",
				},
				layout_strategy = "horizontal",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						mirror = false,
						preview_width = 0.6,
					},
					vertical = {
						prompt_position = "top",
						mirror = false,
					},
					width = 0.75,
					height = 0.4,
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				path_display = { "truncate" },
			},
			pickers = {
				buffers = {
					sort_lastused = true,
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
					},
				},
				find_files = {
					find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
					hidden = true,
				},
				current_buffer_fuzzy_find = {},
				file_browser = {},
				oldfiles = {},
				commands = {},
				lsp_references = {},
				lsp_definitions = {},
				lsp_document_symbols = {},
				lsp_workspace_symbols = {},
				diagnostics = {
					mappings = {
						i = {
							["<m-e>"] = function()
								vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(" <C-o>cc:error: ", true, true, true), "n", true)
							end,
							["<m-i>"] = function()
								vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(" <C-o>cc:info: ", true, true, true), "n", true)
							end,
							["<m-w>"] = function()
								vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(" <C-o>cc:warn: ", true, true, true), "n", true)
							end,
							["<m-h>"] = function()
								vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(" <C-o>cc:hint: ", true, true, true), "n", true)
							end,
						},
					},
				},
				lsp_code_actions = {},
				help_tags = {},
				live_grep = {
					hidden = true,
				},
				grep_string = {
					hidden = true,
				},
				spell_suggest = {},
				highlights = {},
				keymaps = {},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
			},
		}
		for k, v in pairs(config.pickers) do
			if k ~= "extensions" then
				v.theme = "ivy"
				v.borderchars = {
					--preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					preview = { " " },
				}
			end
		end
		require("telescope").setup(config)
		require("telescope").load_extension("fzf")
	end,
	keys = {
		{
			"<leader><leader>",
			"<cmd>lua require('telescope.builtin').find_files({entry_maker=require('utils').gen_from_file()})<cr>",
		},

		{
			"<leader>ff",
			"<cmd>lua require('telescope.builtin').find_files({"
				.. "entry_maker=require('utils').gen_from_file(),"
				.. "find_command={'fd', '--no-ignore', '--hidden', '--strip-cwd-prefix'}"
				.. "})<cr>",
		},
		{
			"<leader>fp",
			[[<cmd>lua require('telescope.builtin').find_files({cwd="~/.config/nvim"})<cr>]],
		},

		{ "<leader>sp", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
		{ "<leader>gf", "<cmd>lua require('telescope.builtin').grep_string()<cr>" },
		{ "<leader>ss", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>" },
		{ "<leader>su", "<cmd>lua require('telescope.builtin').spell_suggest()<cr>" },

		{ "<leader>hh", "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
		{ "<leader>hi", "<cmd>lua require('telescope.builtin').highlights()<cr>" },
		{ "<leader>km", "<cmd>lua require('telescope.builtin').keymaps()<cr>" },

		{ "<leader>,", "<cmd>lua require('telescope.builtin').buffers()<cr>" },

		{ "<M-x>", "<cmd>lua require('telescope.builtin').commands()<cr>" },
		{ "<leader>:", "<cmd>lua require('telescope.builtin').commands()<cr>" },
		{ "<leader>fr", "<cmd>lua require('telescope.builtin').oldfiles()<cr>" },

		{ "<leader>v", "<cmd>lua require('telescope.builtin').registers()<cr>" },
	},
}
