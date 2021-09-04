local M = {}
M.setup = function()
	local actions = require("telescope.actions")
	require("telescope").setup({
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
			file_ignore_patterns = { "node_modules/", ".git/", ".gitmodules/", "cache" },
			layout_strategy = "horizontal",
			-- sorting_strategy = "descending",
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
		},
		pickers = {
			buffers = {
				sort_lastused = true,
				mappings = {
					i = {
						["<c-d>"] = actions.delete_buffer,
					},
				},
				theme = "ivy",
			},
			find_files = {
				-- previewer = false,
				theme = "ivy",
				hidden = true,
			},
			current_buffer_fuzzy_find = {
				theme = "ivy",
			},
			file_browser = {
				theme = "ivy",
			},
			oldfiles = {
				theme = "ivy",
			},
			commands = {
				theme = "ivy",
			},
			lsp_references = {
				theme = "ivy",
			},
			lsp_definitions = {
				theme = "ivy",
			},
			lsp_document_symbols = {
				theme = "ivy",
			},
			lsp_workspace_symbols = {
				theme = "ivy",
			},
			lsp_document_diagnostics = {
				theme = "ivy",
			},
			lsp_workspace_diagnostics = {
				theme = "ivy",
			},
			lsp_code_actions = {
				theme = "ivy",
			},
			help_tags = {
				theme = "ivy",
			},
			live_grep = {
				theme = "ivy",
				hidden = true,
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = false, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		},
	})
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("projects")
	require("telescope").load_extension("frecency")
end
M.init = function()
	-- map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", NS)

	map(
		"n",
		"<leader><leader>",
		"<cmd>lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_ivy())<cr>:CWD:",
		-- "<cmd>lua require('telescope').extensions.frecency.frecency(require('telescope.themes').get_ivy())<cr>",
		NS
	)
	map("n", "<leader>ff", "<cmd>Telescope find_files find_command=fd,--no-ignore,--hidden<cr>", NS)
	map("n", "<leader>fp", "<cmd>Telescope find_files search_dirs=~/.config/nvim<cr>", NS)

	map("n", "<leader>sp", "<cmd>Telescope live_grep<cr>", NS)
	map("n", "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", NS)

	map("n", "<leader>hh", "<cmd>Telescope help_tags<cr>", NS)

	map("n", "<leader>,", "<cmd>Telescope buffers<cr>", NS)

	map("n", "<M-x>", "<cmd>Telescope commands<cr>", NS)
	map("n", "<leader>:", "<cmd>Telescope commands<cr>", NS)
	map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", NS)
	map("n", "<leader>pp", "<cmd>Telescope projects<cr>", NS)
end
return M
