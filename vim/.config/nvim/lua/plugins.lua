local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({ "lewis6991/impatient.nvim" })

	-- lsp
	use({ "williamboman/nvim-lsp-installer" })
	use({
		"neovim/nvim-lspconfig",
		after = { "nvim-lsp-installer" },
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
	use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
	use({ "kwkarlwang/cmp-nvim-insert-text-lsp", after = "nvim-cmp" })
	use({ "f3fora/cmp-spell", after = "nvim-cmp" })
	use({
		"petertriho/cmp-git",
		after = "nvim-cmp",
		config = function()
			require("cmp_git").setup()
		end,
	})
	-- use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
	use({
		"hrsh7th/nvim-cmp",
		-- disable = true,
		config = function()
			require("plugins.cmp")
		end,
	})

	use({
		"L3MON4D3/LuaSnip",
		requires = { "friendly-snippets" },
		config = function()
			require("plugins.luasnip")
		end,
	})
	use({ "rafamadriz/friendly-snippets" })

	-- theme
	use({
		"kwkarlwang/vim-dracula",
		as = "dracula",
		setup = function()
			g.dracula_full_special_attrs_support = 1
		end,
		config = function()
			--------Theme-----------
			vim.cmd("colorscheme dracula")
		end,
	})
	-- comment function
	use({
		"numToStr/Comment.nvim",
		after = "nvim-ts-context-commentstring",
		config = function()
			require("plugins.comment")
		end,
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
		end,
	})

	use("kyazdani42/nvim-web-devicons")

	-- statusline
	use({
		"feline-nvim/feline.nvim",
		config = function()
			require("plugins.feline")
		end,
	})

	-- for telescope
	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		module = "telescope",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		setup = function()
			require("plugins.telescope").init()
		end,
		config = function()
			require("plugins.telescope").setup()
		end,
	})

	-- Treesitter plugins
	-- make color brackets
	use({ "p00f/nvim-ts-rainbow" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects" })
	use({ "windwp/nvim-ts-autotag" })

	use({
		"s1n7ax/nvim-comment-frame",
		keys = { { "n", "cm" } },
		config = function()
			require("nvim-comment-frame").setup({
				keymap = "cm",
				multiline_keymap = "cm",
			})
		end,
	})

	--------Tree Sitter-----------
	use({
		"nvim-treesitter/nvim-treesitter",
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
	})

	-- git
	use({
		"tpope/vim-fugitive",
		cmd = { "Git", "Gdiffsplit!", "Gdiffsplit", "Git mergetool" },
		setup = function()
			map("n", "<leader>gd", ":Gdiffsplit!<cr>", NS)
			map("n", "<leader>gh", ":diffget 2<cr>", NS)
			map("n", "<leader>gl", ":diffget 3<cr>", NS)
			map("n", "<leader>mt", ":Git mergetool", NS)
		end,
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
	})
	use({
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				hooks = {
					diff_buf_read = function()
						vim.cmd([[set nocursorline]])
					end,
				},
			})
		end,
	})

	-- terminal
	use({
		"akinsho/nvim-toggleterm.lua",
		cmd = { "ToggleTerm", "TermExec" },
		setup = function()
			ToggleTerm = function(direction)
				local isOpen = function()
					local comparator = function(buf)
						return vim.bo[buf].filetype == "toggleterm"
					end

					local wins = api.nvim_list_wins()
					for _, win in pairs(wins) do
						local buf = vim.api.nvim_win_get_buf(win)
						if comparator(buf) then
							return true
						end
					end
					return false
				end
				local command = "ToggleTerm"
				if direction ~= nil then
					command = command .. " direction=" .. direction
				end
				if isOpen() then
					require("bufresize").block_register()
					vim.api.nvim_command(command)
					require("bufresize").resize_close()
				else
					require("bufresize").block_register()
					vim.api.nvim_command(command)
					require("bufresize").resize_open()
					vim.cmd([[execute "normal! i"]])
				end
			end
			map("n", "<C-s>", ":lua ToggleTerm()<cr>", NS)
			map("n", "<leader>ot", [[:lua ToggleTerm("horizontal")<cr>]], NS)
			map("n", "<leader>ol", [[:lua ToggleTerm("vertical")<cr>]], NS)
			map("n", "<leader>of", [[:lua ToggleTerm("float")<cr>]], NS)
			map("i", "<C-s>", "<C-o>:lua ToggleTerm()<cr>", NS)
			map("t", "<C-s>", "<C-\\><C-n>:lua ToggleTerm()<cr>", NS)
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

	use({
		"mg979/vim-visual-multi",
		config = function()
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
			vim.cmd("let g:rnvimr_presets = [{'width': 1.000, 'height': 1.000}]")
		end,
	})

	-- use({
	-- 	"jpalardy/vim-slime",
	-- 	keys = { "n", "<leader>mi" },
	-- 	ft = "python",
	-- })
	-- use({
	-- 	"hanschen/vim-ipython-cell",
	-- 	ft = "python",
	-- 	after = "vim-slime",
	-- 	config = function()
	-- 		require("plugins.ipython")
	-- 	end,
	-- })

	use({
		"jupyter-vim/jupyter-vim",
		disable = true,
		commit = "5500d4a6939038160326309c39550b9bf28915f5",
		ft = "python",
		cmd = "JupyterConnect",
		config = function()
			map("n", "<leader>mj", ":!jupyter qtconsole --style monokai &<cr><cr>:JupyterConnect<cr>", NS)
			map("n", "<C-cr>", ":JupyterSendCell<cr>", NS)
			map("i", "<C-cr>", "<C-o>:JupyterSendCell<cr>", NS)
			map("n", "<S-cr>", ":JupyterSendCell<cr>/# %%<cr>:noh<cr>", NS)
			map("i", "<S-cr>", "<esc>:JupyterSendCell<cr>/# %%<cr>:noh<cr>a", NS)

			map("n", "<leader>ms", "o<esc>0i# %%<cr><esc>", NS)
			map("n", "<leader>mS", "o<esc>0i# %%<cr><esc>kk", NS)
		end,
	})

	use({
		"famiu/bufdelete.nvim",
		module = "bufdelete",
		setup = function()
			map("n", "<leader>bk", ":lua require('bufdelete').bufwipeout(0, true)<cr>", NS)
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
		"ggandor/lightspeed.nvim",
		config = function()
			require("plugins.lightspeed")
		end,
	})

	-- auto session
	use({
		"rmagatti/auto-session",
		-- disable = true,
		config = function()
			require("auto-session").setup({
				log_level = "error",
			})
		end,
	})

	-- highlight search
	use({
		"rktjmp/highlight-current-n.nvim",
		config = function()
			map("n", "N", "<Plug>(highlight-current-n-N)zz", { silent = true })
			map("n", "n", "<Plug>(highlight-current-n-n)zz", { silent = true })
			vim.cmd([[
				augroup HighlightResult
					autocmd!
					autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
				augroup END
			]])
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
		keys = { { "n", ":" } },
		config = function()
			require("numb").setup({ show_numbers = false })
		end,
	})

	use({
		"michaelb/sniprun",
		disable = true,
		run = "bash ./install.sh",
		setup = function()
			map("v", "<leader>rr", "<Plug>SnipRun", { silent = true })
			map("n", "<leader>rl", "mn?# %%<cr>V/# %%<cr><leader>rr`n:noh<cr>", { silent = true })
			map("n", "<leader>rr", "mn:%SnipRun<cr>`nzz", { silent = true })
		end,
		config = function()
			require("sniprun").setup({
				display = {
					"VirtualTextOk",
					"VirtualTextErr",
					"Classic",
				},
			})
		end,
	})

	-- docstring generator
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true,
				input_after_comment = false,
				languages = {
					python = {
						template = {
							annotation_convention = "numpydoc",
						},
					},
					typescriptreact = require("neogen.configurations.typescript"),
					javascriptreact = require("neogen.configurations.javascript"),
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
	use({
		"kwkarlwang/bufjump.nvim",
		-- disable = true,
		config = function()
			require("bufjump").setup({
				forward = "<C-n>",
				backward = "<C-p>",
				on_success = function()
					vim.cmd([[silent! execute "normal! g`\"zz"]])
				end,
			})
		end,
	})

	use({
		"kwkarlwang/bufresize.nvim",
		-- disable = true,
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
	})

	-- markdown
	use({
		"ellisonleao/glow.nvim",
		cmd = "Glow",
	})

	-- swap windows
	use({
		"sindrets/winshift.nvim",
		after = "dracula",
		cmd = "WinShift",
		setup = function()
			map("n", "<leader>ww", ":WinShift<cr>", NS)
		end,
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
	})

	-- mathcup
	use({
		"andymass/vim-matchup",
		config = function()
			-- Go to pair
			map("n", "q", "%", { silent = true })
			map("n", "]q", "]%", { silent = true })
			map("n", "[q", "[%", { silent = true })
			map("x", "q", "%", { silent = true })
			map("x", "aq", "a%", { silent = true })
			map("x", "iq", "i%", { silent = true })
			map("x", "]q", "]%", { silent = true })
			map("x", "[q", "[%", { silent = true })
			map("o", "q", "%", { silent = true })
			map("o", "aq", "a%", { silent = true })
			map("o", "iq", "i%", { silent = true })
			map("o", "]q", "]%", { silent = true })
			map("o", "[q", "[%", { silent = true })
		end,
	})

	-- haskell highlghting (tree sitter too slow)
	use({
		"neovimhaskell/haskell-vim",
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
	})

	-- extend text objects
	use({ "wellle/targets.vim" })

	-- vscode like rename
	-- use({
	-- 	"filipdutescu/renamer.nvim",
	-- 	config = function()
	-- 		require("renamer").setup()
	-- 		map("n", "<leader>cr", "<cmd>lua require('renamer').rename()<cr>", NS)
	-- 	end,
	-- })

	-- yank over ssh
	use({
		"ojroques/vim-oscyank",
		config = function()
			vim.cmd(
				[[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]]
			)
			g.oscyank_silent = true
		end,
	})

	-- spellcheck
	use({
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	})
	-- swap arguments, list elemtns
	use({
		"mizlan/iswap.nvim",
		config = function()
			require("iswap").setup({ autoswap = true })
			map("n", "<leader>is", "<cmd>ISwapWith<cr>", NS)
		end,
	})

	-- format async
	use({
		"lukas-reineke/lsp-format.nvim",
		commit = "84e117b99bb2bc0d0c8122e2b256046f046f8aff",
		config = function()
			require("lsp-format").setup({})
		end,
	})
	-- regex explainer
	use({
		"bennypowers/nvim-regexplainer",
		config = function()
			require("regexplainer").setup()
		end,
		requires = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	})
	-- search and replace
	use({
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
			map("n", "<leader>S", "<cmd>lua require('spectre').open()<cr>", NS)
		end,
	})
	-- protobuf highlighting
	use({ "wfxr/protobuf.vim" })
	use({ "MTDL9/vim-log-highlighting" })
end)
