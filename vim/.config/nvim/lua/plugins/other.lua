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
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				surrounds = {
					["A"] = {
						add = function()
							local am = require("extensions.algomonad")
							local left = am.comment_with_open_identifier()
							local right = am.comment_with_close_identifier()
							return { { left }, { right } }
						end,
					},
				},
			})
		end,
	},
	"tpope/vim-sleuth",
	"tpope/vim-repeat",
	-- pair brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local Rule = require("nvim-autopairs.rule")
			local npairs = require("nvim-autopairs")
			local cond = require("nvim-autopairs.conds")
			local ignored_next_char = string.gsub([[ [%w %% %. %" %' %[ ] ]], "%s+", "")
			npairs.setup({
				disable_filetype = { "TelescopePrompt" },
				ignored_next_char = ignored_next_char,
				map_c_w = true,
			})
			npairs.add_rule(Rule("'", "'", "python"):with_pair(cond.after_text("f")))
			npairs.add_rule(
				Rule("<", ">", { "cpp", "java", "javascript", "typescript", "javascriptreact", "typescriptreact" })
					:with_pair(cond.not_after_regex("%w"))
					:with_pair(cond.before_regex("%w"))
					:with_pair(cond.not_after_text(">"))
			)
		end,
	},
	-- git
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gdiffsplit", "Git mergetool" },
		keys = {
			{ "<leader>gd", "<cmd>Gdiffsplit!<cr>" },
			{ "<leader>gh", "<cmd>diffget 2<cr>" },
			{ "<leader>gl", "<cmd>diffget 3<cr>" },
			{ "<leader>mt", "<cmd>Git mergetool<cr>" },
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
		keys = {
			{ "<leader>do", "<cmd>DiffviewOpen<cr>" },
			{ "<leader>dc", "<cmd>DiffviewClose<cr>" },
		},
		opts = {
			hooks = {
				diff_buf_read = function()
					vim.cmd([[set nocursorline]])
				end,
			},
		},
	},
	-- color hex code
	{
		"NvChad/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup({})
		end,
	},
	{
		"mg979/vim-visual-multi",
		init = function()
			g.VM_silent_exit = 1
			g.VM_show_warnings = 0
			g.VM_default_mappings = 0
			vim.cmd([[
			    let g:VM_maps = {}
			    let g:VM_maps['Find Under'] = '<M-d>'
			    let g:VM_maps['Find Subword Under'] = '<M-d>'
			    let g:VM_maps['Select All'] = '<C-M-d>'
			    let g:VM_maps['Seek Next'] = 'n'
			    let g:VM_maps['Seek Prev'] = 'N'
			    let g:VM_maps["Undo"] = 'u'
			    let g:VM_maps["Redo"] = '<C-r>'
			    let g:VM_maps["Remove Region"] = '<cr>'
			]])
		end,
	},
	"gpanders/editorconfig.nvim",
	{
		"kevinhwang91/rnvimr",
		cmd = "RnvimrToggle",
		keys = { { "<leader>.", "<cmd>RnvimrToggle<cr><esc>" } },
		config = function()
			g.rnvimr_enable_ex = 1
			g.rnvimr_enable_picker = 1
			g.rnvimr_enable_bw = 1
			vim.cmd("let g:rnvimr_presets = [{'width': 1.000, 'height': 1.000}]")
		end,
	},
	{
		"famiu/bufdelete.nvim",
		keys = { { "<leader>bk", "<cmd>lua require('bufdelete').bufwipeout(0, true)<cr>" } },
	},
	{
		"rmagatti/auto-session",
		opts = {
			log_level = "error",
		},
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
	-- correct python indentation
	{
		"Vimjas/vim-python-pep8-indent",
		ft = "python",
	},
	-- Write Read without sudo permission
	{
		"lambdalisue/suda.vim",
		cmd = { "SudaRead", "SudaWrite" },
	},
	{
		"nacro90/numb.nvim",
		keys = ":",
		config = function()
			require("numb").setup({ show_numbers = false })
		end,
	},
	-- docstring generator
	{
		"danymat/neogen",
		keys = {
			{ "cd", "<cmd>lua require('neogen').generate()<cr>" },
		},
		opts = {
			enabled = true,
			input_after_comment = false,
			languages = {
				python = {
					template = {
						annotation_convention = "numpydoc",
					},
				},
				-- typescriptreact = require("neogen.configurations.typescript"),
				-- javascriptreact = require("neogen.configurations.javascript"),
			},
		},
	},
	{
		"kwkarlwang/bufjump.nvim",
		config = function()
			require("bufjump").setup({
				forward = "<C-n>",
				backward = "<C-p>",
				on_success = function()
					vim.cmd([[silent! execute "normal! g`\"zz"]])
				end,
			})
		end,
	},
	{
		"kwkarlwang/bufresize.nvim",
		config = function()
			require("bufresize").setup({
				register = {
					keys = {
						{ "n", "<leader>w<", "30<C-w><", NS },
						{ "n", "<leader>w>", "30<C-w>>", NS },
						{ "n", "<leader>w+", "10<C-w>+", NS },
						{ "n", "<leader>w-", "10<C-w>-", NS },
						{ "n", "<leader>w_", "<C-w>_", NS },
						{ "n", "<leader>w=", "<C-w>=", NS },
						{ "n", "<leader>w|", "<C-w>|", NS },
						{ "n", "<leader>wo", "<C-w>|<C-w>_", NS },
						{ "", "<LeftRelease>", "<LeftRelease>", NS },
						{ "i", "<LeftRelease>", "<LeftRelease><C-o>", NS },
					},
				},
				resize = {
					increment = 5,
				},
			})
		end,
	},
	-- markdown
	{
		"ellisonleao/glow.nvim",
		cmd = "Glow",
		config = true,
		ft = "markdown",
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"AckslD/nvim-FeMaco.lua",
		config = function()
			require("femaco").setup()
		end,
		ft = "markdown",
	},
	-- markdown link conceal
	{ "preservim/vim-markdown", enabled = true },
	-- swap windows
	{
		"sindrets/winshift.nvim",
		-- after = "dracula",
		cmd = "WinShift",
		keys = {
			{ "<leader>ww", "<cmd>WinShift<cr>" },
		},
		config = function()
			require("winshift").setup({
				highlight_moving_win = true,
				focused_hl_group = "DraculaBgDark",
				moving_win_options = {
					wrap = false,
					cursorline = false,
					cursorcolumn = false,
				},
			})
		end,
	},
	{
		"andymass/vim-matchup",
		lazy = false,
		keys = {
			-- Go to pair
			{ "q", "%", mode = { "n", "x", "o" }, remap = true },
			{ "]q", "]%", mode = { "n", "x", "o" }, remap = true },
			{ "[q", "[%", mode = { "n", "x", "o" }, remap = true },
			{ "aq", "a%", mode = { "x", "o" }, remap = true },
			{ "iq", "i%", mode = { "x", "o" }, remap = true },
		},
	},
	-- haskell highlghting (tree sitter too slow)
	{
		"neovimhaskell/haskell-vim",
		enabled = true,
		ft = "haskell",
		config = function()
			g.haskell_enable_quantification = 0
			g.haskell_enable_recursivedo = 0
			g.haskell_enable_arrowsyntax = 0
			g.haskell_enable_pattern_synonyms = 0
			g.haskell_enable_typeroles = 0
			g.haskell_enable_static_pointers = 0
			g.haskell_backpack = 0
			g.haskell_classic_highlighting = 0
			-- cmd([[hi link haskellIdentifier Tag]])
		end,
	},
	-- extend text objects
	"wellle/targets.vim",
	-- yank over ssh
	{
		"ojroques/nvim-osc52",
		config = function()
			require("osc52").setup({
				silent = true,
			})
			local function copy()
				require("osc52").copy_register(vim.v.event.regname)
			end

			vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
		end,
	},
	-- swap arguments, list elements
	{
		"mizlan/iswap.nvim",
		keys = {
			{ "<leader>is", "<cmd>ISwapWith<cr>" },
		},
		config = function()
			require("iswap").setup({ autoswap = true, flash_style = nil, hl_flash = "" })
			map("n", "<leader>is", "<cmd>ISwapWith<cr>", NS)
		end,
	},
	-- search and replace
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>S", "<cmd>lua require('spectre').open()<cr>" },
		},
		config = function()
			require("spectre").setup()
		end,
	},
	"MTDL9/vim-log-highlighting",
	-- ui library
	{
		"stevearc/dressing.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				select = {
					telescope = require("telescope.themes").get_ivy(),
				},
			})
		end,
	},
	-- java lsp
	"mfussenegger/nvim-jdtls",
	-- better fold
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
			},
		},
		config = function()
			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	-- better quickfix
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		init = function()
			require("utils").quickfix()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
			require("notify").setup({
				background_colour = "#000000",
			})
			map("n", "<Esc>", ":noh<cr><cmd>lua require('notify').dismiss()<cr>", NS)
		end,
	},

	-- code runner
	{
		"CRAG666/code_runner.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = { { "<leader>r", "<cmd>RunCode<cr>", NS } },
		config = function()
			require("code_runner").setup({
				mode = "toggleterm",
				filetype = {
					java = "cd $dir && java $fileName",
					python = "python3 -u",
					cpp = "cd $dir && cpp $fileName",
					go = "cd $dir && go run $fileName",
					typescript = "cd $dir && ts-node $fileName",
					scala = "cd $dir && scala $fileName",
					rust = "cd $dir && rustc $fileName && ./$fileNameWithoutExt || true && rm $fileNameWithoutExt",
				},
			})
		end,
	},

	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.move").setup({
				mappings = {
					-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
					left = "<M-left>",
					right = "<M-right>",
					down = "<M-down>",
					up = "<M-up>",

					-- Move current line in Normal mode
					line_left = "<M-left>",
					line_right = "<M-right>",
					line_down = "<M-down>",
					line_up = "<M-up>",
				},
			})
		end,
	},
	{
		"Equilibris/nx.nvim",
		enabled = false,
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("nx").setup()
		end,
	},
	-- scala lsp
	{
		"scalameta/nvim-metals",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- haskell lsp
	{
		"MrcJkb/haskell-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		ft = "haskell",
		branch = "1.x.x",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = { enabled = false },
	},
	{ "yioneko/nvim-vtsls" },
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local rt = require("rust-tools")
			rt.setup({
				server = {
					on_attach = function(client, bufnr)
						require("plugins.lsp.config").on_attach(client, bufnr)
						-- client.server_capabilities.documentFormattingProvider = true
						-- -- Hover actions
						-- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- -- Code action groups
						-- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
					end,
				},
			})
		end,
	},
	{ "folke/neodev.nvim", opts = {} },
	{ "Almo7aya/openingh.nvim" },
	{
		"mikesmithgh/kitty-scrollback.nvim",
		enabled = true,
		lazy = true,
		cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
		event = { "User KittyScrollbackLaunch" },
		-- version = '*', -- latest stable version, may have breaking changes if major version changed
		-- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
		config = function()
			require("kitty-scrollback").setup({
				visual_selection_highlight_mode = "nvim",
				ksb_example_get_text_last_non_empty_output = {
					kitty_get_text = {
						extent = "last_non_empty_output",
						ansi = true,
					},
				},
			})
		end,
	},
}
