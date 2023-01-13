return {
	-- theme
	{
		"kwkarlwang/vim-dracula",
		name = "dracula",
		priority = 1000,
		init = function()
			g.dracula_full_special_attrs_support = 1
		end,
		config = function()
			vim.cmd("colorscheme dracula")
		end,
	},
	{
		"kylechui/nvim-surround",
		config = true,
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
				Rule("<", ">", { "cpp", "java" })
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
			{ "<leader>gd", ":Gdiffsplit!<cr>" },
			{ "<leader>gh", ":diffget 2<cr>" },
			{ "<leader>gl", ":diffget 3<cr>" },
			{ "<leader>mt", ":Git mergetool" },
		},
	},
	{
		"TimUntersberger/neogit",
		-- commit = "4cc4476acbbc772f29fd6c1ccee43f58a29a1b13",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Neogit",
		keys = { { "<leader>gg", "<cmd>Neogit<cr>" } },
		config = function()
			require("neogit").setup({
				disable_commit_confirmation = true,
				disable_commit_notifications = true,
				disable_context_highlighting = false,
				disable_hint = true,
				integrations = {
					diffview = true,
				},
				sections = {
					untracked = {
						folded = false,
					},
					unstaged = {
						folded = false,
					},
					staged = {
						folded = false,
					},
					stashes = {
						folded = false,
					},
					unpulled = {
						folded = false,
					},
					unmerged = {
						folded = false,
					},
					recent = {
						folded = false,
					},
				},
				mappings = {
					status = { ["p"] = "PushPopup", ["P"] = "", ["F"] = "PullPopup" },
				},
			})
			vim.cmd([[
				hi! link NeogitDiffAddHighlight DiffAdd
				hi! link NeogitDiffDeleteHighlight DiffDelete
				hi NeogitDiffContextHighlight guibg=#1E2029
			]])
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },

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
			require("colorizer").setup()
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
		keys = { { "<leader>.", "<cmd>RnvimrToggle<cr>" } },
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
	{ "preservim/vim-markdown", enabled = false },
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
		enabled = false,
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
				startinsert = true,
				filetype_path = "",
				project_path = "",
				filetype = {
					java = "cd $dir && java $fileName",
					python = "python3 -u",
					cpp = "cd $dir && cpp $fileName",
					go = "cd $dir && go run $fileName",
				},
			})
		end,
	},
}
