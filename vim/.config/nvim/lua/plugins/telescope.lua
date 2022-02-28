local M = {}
M.setup = function()
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
			file_ignore_patterns = { "node_modules/", ".git/", ".gitmodules/", "cache", "__pycache__/" },
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
			diagnostics = {},
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
end

M.init = function()
	map(
		"n",
		"<leader><leader>",
		"<cmd>lua require('telescope.builtin').find_files({entry_maker=require('utils').gen_from_file()})<cr>",
		NS
	)

	map(
		"n",
		"<leader>ff",
		"<cmd>lua require('telescope.builtin').find_files({"
			.. "entry_maker=require('utils').gen_from_file(),"
			.. "find_command={'fd', '--no-ignore', '--hidden', '--strip-cwd-prefix'}"
			.. "})<cr>",
		NS
	)
	map("n", "<leader>fp", "<cmd>Telescope find_files search_dirs=~/.config/nvim<cr>", NS)

	map("n", "<leader>sp", "<cmd>lua require('telescope.builtin').live_grep()<cr>", NS)
	map("n", "<leader>gf", "<cmd>Telescope grep_string<cr>", NS)
	map("n", "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", NS)
	map("n", "<leader>su", "<cmd>Telescope spell_suggest<cr>", NS)

	map("n", "<leader>hh", "<cmd>Telescope help_tags<cr>", NS)
	map("n", "<leader>hi", "<cmd>Telescope highlights<cr>", NS)
	map("n", "<leader>km", "<cmd>Telescope keymaps<cr>", NS)

	map("n", "<leader>,", "<cmd>Telescope buffers<cr>", NS)

	map("n", "<M-x>", "<cmd>Telescope commands<cr>", NS)
	map("n", "<leader>:", "<cmd>Telescope commands<cr>", NS)
	map("n", "<leader>fr", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", NS)

	map("n", "<leader>v", "<cmd>Telescope registers<cr>", NS)
end
return M
