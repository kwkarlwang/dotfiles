local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- lsp
	use({
		"kabouzeid/nvim-lspinstall",
	})
	use({
		"neovim/nvim-lspconfig",
		after = { "nvim-lspinstall", "nvim-lsp-ts-utils" },
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("plugins.null-ls")
		end,
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})
	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
	})
	use({
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				doc_lines = 0,
				floating_window = true,
				hi_parameter = "Visual",
				handler_opts = {
					border = "none",
				},
				hint_enable = false,
			})
		end,
	})

	-- completion
	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
	use({ "tzachar/cmp-tabnine", run = "./install.sh", after = "nvim-cmp" })

	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("plugins.cmp")
		end,
	})

	use({
		"L3MON4D3/LuaSnip",
		requires = { "friendly-snippets" },
		event = "BufWinEnter",
		config = function()
			require("plugins.luasnip")
		end,
	})
	use({ "rafamadriz/friendly-snippets" })

	-- theme
	use({
		"kwkarlwang/vim-dracula",
		as = "dracula",
		config = function()
			--------Theme-----------
			cmd("colorscheme dracula")
		end,
	})

	-- comment function
	use({
		"b3nj5m1n/kommentary",
		keys = {
			"<Plug>kommentary_line_default",
			"<Plug>kommentary_visual_default",
		},
		setup = function()
			map("n", "cc", "<Plug>kommentary_line_default", {})
			map("v", "cc", "<Plug>kommentary_visual_default<Esc>", {})
		end,
		config = function()
			g.kommentary_create_default_mappings = false
			require("kommentary.config").configure_language("default", {
				prefer_single_line_comments = true,
			})
		end,
	})
	-- comment frame
	use({
		"s1n7ax/nvim-comment-frame",
		requires = "nvim-treesitter",
		keys = { "n", "cm" },
		config = function()
			require("nvim-comment-frame").setup({
				keymap = "cm",
				multiline_keymap = "cm",
			})
		end,
	})

	use("kyazdani42/nvim-web-devicons")

	-- statusline
	use({
		"kwkarlwang/galaxyline.nvim",
		branch = "main",
		event = "BufRead",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.galaxyline")
		end,
	})

	-- use {
	--   "hoob3rt/lualine.nvim",
	--   requires = {"kyazdani42/nvim-web-devicons", opt = true},
	--   config = function()
	--     require "plugins.lualine"
	--   end
	-- }

	-- for telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			{
				"ahmedkhalf/project.nvim",
				cmd = "Telescope",
				module = "telescope",
				config = function()
					require("plugins.project")
				end,
			},
			-- { "nvim-telescope/telescope-frecency.nvim", requires = { "tami5/sql.nvim" } },
		},
		after = "project.nvim",
		setup = function()
			require("plugins.telescope").init()
		end,
		config = function()
			require("plugins.telescope").setup()
		end,
	})
	-- make color brackets
	use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects", branch = "0.5-compat", after = "nvim-treesitter" })
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	--------Tree Sitter-----------
	use({
		"nvim-treesitter/nvim-treesitter",
		branch = "0.5-compat",
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	})

	use("tpope/vim-surround")
	use("tpope/vim-sleuth")
	use("tpope/vim-repeat")
	-- pair brackets
	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			local ignored_next_char = string.gsub([[ [%w%%%%[%%.] ]], "%s+", "")
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt" },
				ignored_next_char = ignored_next_char,
			})
			require("nvim-autopairs.completion.cmp").setup({
				map_cr = true, --  map <CR> on insert mode
				map_complete = false, -- it will auto insert `(` after select function or method item
			})
		end,
	})

	-- git
	use({
		"tpope/vim-fugitive",
		cmd = "Git",
	})

	use({
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
		cmd = "Neogit",
		setup = function()
			map("n", "<leader>gg", ":Neogit<cr>", NS)
		end,
		config = function()
			require("neogit").setup({
				disable_commit_confirmation = true,
				disable_commit_notifications = true,
				integrations = {
					diffview = true,
				},
			})
		end,
	})
	use({
		"sindrets/diffview.nvim",
		after = "neogit",
		config = function()
			require("diffview").setup()
		end,
	})

	-- terminal
	use({
		"akinsho/nvim-toggleterm.lua",
		cmd = { "ToggleTerm", "TermExec" },
		setup = function()
			map("n", "<leader>ot", ":ToggleTerm direction=horizontal<cr>i", NS)
			map("n", "<leader>ol", ":ToggleTerm direction=vertical<cr>i", NS)
			map("n", "<C-s>", ":ToggleTerm<cr>i", NS)
			map("i", "<C-s>", "<esc>:ToggleTerm<cr>i", NS)
		end,
		config = function()
			require("plugins.term")
		end,
	})

	-- tree structure
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		setup = function()
			require("plugins.tree").init()
		end,
		config = function()
			require("plugins.tree").setup()
		end,
	})

	-- color hex code
	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Formatter.nvim
	-- use {
	--   "mhartington/formatter.nvim",
	--   cmd = {"Format", "FormatWrite"},
	--   setup = function()
	--     ------ FORMAT ON SAVE
	--     -- vim.api.nvim_exec(
	--     --   [[
	--     --     augroup FormatAutogroup
	--     --       autocmd!
	--     --       autocmd BufWritePost * :silent FormatWrite
	--     --     augroup END
	--     --     ]]--,
	--     --   true
	--     -- )
	--     map("n", "<leader>cf", ":silent Format<cr>", NS)
	--     map("n", "ss", ":silent up<cr>:silent FormatWrite<cr>", NS)
	--   end,
	--   config = function()
	--     require "plugins.formatter"
	--   end
	-- }

	use({
		"mg979/vim-visual-multi",
		config = function()
			g.VM_silent_exit = 1
			g.VM_show_warnings = 0
			g.VM_default_mappings = 0
			cmd([[
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
	})
	-- leetcode
	use({
		"ianding1/leetcode.vim",
		cmd = { "LeetCodeList", "LeetCodeSignIn", "LeetCodeSubmit", "LeetCodeTest" },
		config = function()
			g.leetcode_browser = "chrome"
			g.leetcode_hide_paid_only = 1
			g.leetcode_solution_filetype = "python3"
		end,
	})

	-- automatic adjust indentation
	use({
		"editorconfig/editorconfig-vim",
		config = function()
			g.EditorConfig_exclude_patterns = { "fugitive://.*" }
		end,
	})

	-- ranger
	use({
		"kevinhwang91/rnvimr",
		cmd = "RnvimrToggle",
		setup = function()
			map("n", "<leader>.", ":RnvimrToggle<cr>", NS)
		end,
		config = function()
			g.rnvimr_enable_ex = 1
			g.rnvimr_enable_picker = 1
			g.rnvimr_enable_bw = 1
			cmd("let g:rnvimr_presets = [{'width': 1.000, 'height': 1.000}]")
		end,
	})

	use({
		"jpalardy/vim-slime",
		keys = { "n", "<leader>mi" },
		ft = "python",
	})
	use({
		"hanschen/vim-ipython-cell",
		ft = "python",
		after = "vim-slime",
		config = function()
			require("plugins.ipython")
		end,
	})

	use({
		"jupyter-vim/jupyter-vim",
		ft = "python",
		cmd = "JupyterConnect",
		config = function()
			map("n", "<leader>mj", ":!jupyter qtconsole --style monokai &<cr><cr>:JupyterConnect<cr>", NS)
			map("n", "<C-cr>", ":JupyterSendCell<cr>", NS)
			map("i", "<C-cr>", "<esc>:JupyterSendCell<cr>i", NS)
			map("n", "<S-cr>", ":JupyterSendCell<cr>/# %%<cr>:noh<cr>", NS)
			map("i", "<S-cr>", "<esc>:JupyterSendCell<cr>/# %%<cr>:noh<cr>i", NS)

			map("n", "<leader>ms", "o<esc>0i# %%<cr><esc>", NS)
			map("n", "<leader>mS", "o<esc>0i# %%<cr><esc>kk", NS)
		end,
	})

	use({
		"kdheepak/lazygit.nvim",
		setup = function()
			map("n", "<leader>og", ":LazyGit<cr>", NS)
		end,
		cmd = "LazyGit",
		config = function()
			cmd([[
        if has('nvim') && executable('nvr')
          let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
        endif
        ]])
		end,
	})

	use({
		"famiu/bufdelete.nvim",
		event = "BufWinEnter",
		keys = { "n", "<leader>bk" },
		config = function()
			map("n", "<leader>bk", ":lua require('bufdelete').bufdelete(0, true)<cr>", NS)
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.gitsigns")
		end,
	})

	-- motion related
	use({
		"phaazon/hop.nvim",
		as = "hop",
		event = "BufWinEnter",
		disable = true,
		setup = function()
			require("plugins.hop").init()
		end,
		config = function()
			require("plugins.hop").setup()
		end,
	})
	use({
		"ggandor/lightspeed.nvim",
		event = "BufWinEnter",
		config = function()
			require("plugins.lightspeed")
		end,
	})

	-- auto session
	use({
		"rmagatti/auto-session",
		event = "BufWinEnter",
		config = function()
			require("auto-session").setup({
				log_level = "error",
			})
		end,
	})

	-- highlight search
	use({
		"rktjmp/highlight-current-n.nvim",
		keys = { { "n", "/" }, { "n", "*" }, { "n", "n" }, { "n", "N" } },
		config = function()
			map("n", "n", "<Plug>(highlight-current-n-n)zz", {})
			map("n", "N", "<Plug>(highlight-current-n-N)zz", {})
		end,
	})

	-- correct python indentation
	use({
		"Vimjas/vim-python-pep8-indent",
		ft = "python",
	})

	-- Write Read without sudo permission
	use({
		"lambdalisue/suda.vim",
		cmd = { "SudaRead", "SudaWrite" },
	})

	-- peek number
	use({
		"nacro90/numb.nvim",
		keys = { "n", ":" },
		config = function()
			require("numb").setup({ show_numbers = false })
		end,
	})

	-- code runner
	-- use({
	-- 	"CRAG666/code_runner.nvim",
	-- 	keys = { "n", "<leader>r" },
	-- 	config = function()
	-- 		require("code_runner").setup({
	-- 			term = {
	-- 				position = "vert",
	-- 				size = 100,
	-- 			},
	-- 		})
	-- 	end,
	-- })
	use({
		"michaelb/sniprun",
		run = "bash ./install.sh",
		keys = { { "n", "<leader>rr" }, { "v", "<leader>rr" }, { "n", "<leader>rl" } },
		setup = function()
			map("v", "<leader>rr", "<Plug>SnipRun", { silent = true })
			map("n", "<leader>rl", "mn?# %%<cr>V*k<leader>rr`n:noh<cr>", { silent = true })
			map("n", "<leader>rr", "mn:%SnipRun<cr>`n", { silent = true })
		end,
		config = function()
			require("sniprun").setup({
				display = {
					"VirtualTextOk",
					"VirtualTextErr",
					"Terminal",
				},
			})
		end,
	})

	-- docstring generator
	use({
		"danymat/neogen",
		keys = { "n", "cd" },
		config = function()
			require("neogen").setup({
				enable = true,
				languages = {
					python = {
						template = {
							annotation_convention = "numpydoc",
						},
					},
				},
			})
			map("n", "cd", ":lua require('neogen').generate()<cr>", NS)
		end,
	})

	-- Debugger
	use({
		"mfussenegger/nvim-dap",
		module = "dap",
		setup = function()
			require("plugins.dap").init()
		end,
	})
	use({
		"Pocco81/DAPInstall.nvim",
		after = "nvim-dap",
		config = function()
			require("plugins.dap").setup()
		end,
	})
	use({
		"rcarriga/nvim-dap-ui",
		after = "nvim-dap",
		config = function()
			require("dapui").setup()
		end,
	})
end)
