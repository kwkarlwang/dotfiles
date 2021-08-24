local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  execute "packadd packer.nvim"
end
return require("packer").startup(
  function(use)
    use "wbthomason/packer.nvim"

    -- lsp
    use {
      "kabouzeid/nvim-lspinstall"
    }
    use {
      "neovim/nvim-lspconfig",
      after = "nvim-lspinstall",
      config = function()
        require "plugins.lsp"
      end
    }
    use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function()
        require "lsp_signature".setup(
          {
            bind = true,
            doc_lines = 0,
            floating_window = true,
            hi_parameter = "Visual",
            handler_opts = {
              border = "none"
            },
            hint_enable = false
          }
        )
      end
    }

    -- completion
    -- use {
    --   "hrsh7th/nvim-compe",
    --   event = "InsertEnter",
    --   disable = true,
    --   config = function()
    --     require "plugins.compe".setup()
    --   end
    -- }

    use {
      "hrsh7th/cmp-vsnip",
      after = "nvim-cmp"
    }

    use {
      "hrsh7th/cmp-emoji",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-nvim-lua",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-calc",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-path",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-cmp"
    }

    use {
      "hrsh7th/nvim-cmp",
      after = "nvim-lspconfig",
      config = function()
        require "plugins.cmp"
      end
    }

    use {
      "hrsh7th/vim-vsnip",
      event = "InsertEnter"
      -- config = function()
      --   map("i", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)':'<Tab>'", {expr = true})
      --   map("s", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)':'<Tab>'", {expr = true})
      --   map("i", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)':'<S-Tab>'", {expr = true})
      --   map("s", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)':'<S-Tab>'", {expr = true})
      -- end
    }
    use {
      "rafamadriz/friendly-snippets",
      event = "InsertCharPre"
    }

    -- theme
    use {
      "kwkarlwang/vim-dracula",
      as = "dracula",
      config = function()
        --------Theme-----------
        cmd "colorscheme dracula"
      end
    }

    -- comment function
    use {
      "b3nj5m1n/kommentary",
      keys = {
        {"n", "cc"},
        {"v", "cc"}
      },
      config = function()
        g.kommentary_create_default_mappings = false
        map("n", "cc", "<Plug>kommentary_line_default", {})
        map("v", "cc", "<Plug>kommentary_visual_default<Esc>", {})
        require("kommentary.config").configure_language(
          "default",
          {
            prefer_single_line_comments = true
          }
        )
      end
    }
    -- comment frame
    use {
      "s1n7ax/nvim-comment-frame",
      requires = "nvim-treesitter",
      keys = {
        "n",
        "<leader>cm"
      },
      config = function()
        require("nvim-comment-frame").setup(
          {
            keymap = "<leader>cm",
            multiline_keymap = "<leader>cm"
          }
        )
      end
    }

    use "kyazdani42/nvim-web-devicons"

    -- statusline
    use {
      "kwkarlwang/galaxyline.nvim",
      branch = "main",
      event = "BufRead",
      requires = {"kyazdani42/nvim-web-devicons", opt = true},
      config = function()
        require("plugins.galaxyline")
      end
    }

    -- use {
    --   "hoob3rt/lualine.nvim",
    --   requires = {"kyazdani42/nvim-web-devicons", opt = true},
    --   config = function()
    --     require "plugins.lualine"
    --   end
    -- }

    -- for telescope
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        {"nvim-lua/popup.nvim"},
        {"nvim-lua/plenary.nvim"},
        {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
        {
          "ahmedkhalf/project.nvim",
          cmd = "Telescope",
          config = function()
            require("plugins.project")
          end
        }
        -- {"nvim-telescope/telescope-frecency.nvim", requires = {"tami5/sql.nvim"}}
      },
      after = "project.nvim",
      setup = function()
        require "plugins.telescope".init()
      end,
      config = function()
        require "plugins.telescope".setup()
      end
    }
    -- make color brackets
    use {
      "p00f/nvim-ts-rainbow",
      after = "nvim-treesitter"
    }
    --------Tree Sitter-----------
    use {
      "nvim-treesitter/nvim-treesitter",
      branch = "0.5-compat",
      run = ":TSUpdate",
      config = function()
        require "nvim-treesitter.configs".setup {
          ensure_installed = "maintained",
          ignore_install = {"haskell"},
          indent = {
            enable = true,
            disable = {"python"}
          },
          highlight = {enable = true},
          rainbow = {
            enable = true,
            extended_modes = false,
            colors = {
              "#ebcb8b",
              "#f199ce",
              "#569cd6",
              "#a3c4ef",
              "#acebfb",
              "#ee766d"
            }
          }
        }
      end
    }

    use "tpope/vim-surround"
    use "tpope/vim-sleuth"
    use "tpope/vim-repeat"
    -- pair brackets
    use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("nvim-autopairs").setup {
          disable_filetype = {"TelescopePrompt"}
        }
        -- require("nvim-autopairs.completion.compe").setup(
        --   {
        --     map_cr = true, --  map <CR> on insert mode
        --     map_complete = false -- it will auto insert `(` after select function or method item
        --   }
        -- )
        require("nvim-autopairs.completion.cmp").setup(
          {
            map_cr = true, --  map <CR> on insert mode
            map_complete = false -- it will auto insert `(` after select function or method item
          }
        )
      end
    }

    -- git
    use {
      "tpope/vim-fugitive",
      cmd = "Git"
      -- setup = function()
      --   map("n", "<leader>gp", ":Git push<cr>", {noremap = true})
      -- end
    }

    use {
      "TimUntersberger/neogit",
      requires = "nvim-lua/plenary.nvim",
      cmd = "Neogit",
      setup = function()
        map("n", "<leader>gg", ":Neogit<cr>", NS)
      end,
      config = function()
        require("neogit").setup(
          {
            disable_commit_confirmation = true
          }
        )
      end
    }

    -- terminal
    use {
      "akinsho/nvim-toggleterm.lua",
      keys = {"n", "<C-s>"},
      cmd = {"ToggleTerm", "TermExec"},
      config = function()
        require "plugins.term"
      end
    }

    -- tree structure
    use {
      "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      setup = function()
        require("plugins.tree").init()
      end,
      config = function()
        require("plugins.tree").setup()
      end
    }

    -- color hex code
    use {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require "colorizer".setup()
      end
    }

    -- Formatter.nvim
    use {
      "mhartington/formatter.nvim",
      cmd = {"Format", "FormatWrite"},
      setup = function()
        ------ FORMAT ON SAVE
        vim.api.nvim_exec(
          [[
            augroup FormatAutogroup
              autocmd!
              autocmd BufWritePost * :silent FormatWrite
            augroup END
            ]],
          true
        )
        map("n", "<leader>cf", ":silent Format<cr>", {noremap = true, silent = true})
      end,
      config = function()
        require "plugins.formatter"
      end
    }

    use {
      "mg979/vim-visual-multi",
      config = function()
        g.VM_silent_exit = 1
        g.VM_show_warnings = 0
        g.VM_default_mappings = 0
        cmd [[
            let g:VM_maps = {}
            let g:VM_maps['Find Under'] = '<M-d>'
            let g:VM_maps['Find Subword Under'] = '<M-d>'
            let g:VM_maps['Select All'] = '<C-M-d>'
            let g:VM_maps['Seek Next'] = 'n'
            let g:VM_maps['Seek Prev'] = 'N'
            let g:VM_maps["Undo"] = 'u'
            let g:VM_maps["Redo"] = '<C-r>'
            let g:VM_maps["Remove Region"] = '<cr>'
        ]]
      end
    }
    -- leetcode
    use {
      "ianding1/leetcode.vim",
      cmd = {"LeetCodeList", "LeetCodeSignIn"},
      config = function()
        g.leetcode_browser = "chrome"
        g.leetcode_hide_paid_only = 1
        g.leetcode_solution_filetype = "python3"
      end
    }

    -- automatic adjust indentation
    use {
      "editorconfig/editorconfig-vim",
      config = function()
        g.EditorConfig_exclude_patterns = {"fugitive://.*"}
      end
    }

    -- ranger
    use {
      "kevinhwang91/rnvimr",
      cmd = "RnvimrToggle",
      setup = function()
        map("n", "<leader>.", ":RnvimrToggle<cr>", NS)
      end,
      config = function()
        g.rnvimr_enable_ex = 1
        g.rnvimr_enable_picker = 1
        g.rnvimr_enable_bw = 1
        cmd "let g:rnvimr_presets = [{'width': 1.000, 'height': 1.000}]"
      end
    }

    -- use {
    --   "jpalardy/vim-slime",
    --   ft = "python"
    -- }
    -- use {
    --   "hanschen/vim-ipython-cell",
    --   ft = "python",
    --   after = "vim-slime",
    --   config = function()
    --     require("plugins.ipython")
    --   end
    -- }

    use {
      "jupyter-vim/jupyter-vim",
      ft = "python",
      cmd = "JupyterConnect",
      setup = function()
        map("n", "<leader>mjj", ":!jupyter qtconsole --style monokai &<cr><cr>:JupyterConnect<cr>", NS)
        map("n", "<C-cr>", ":JupyterSendCell<cr>", NS)
        map("i", "<C-cr>", "<esc>:JupyterSendCell<cr>i", NS)
        map("n", "<S-cr>", ":JupyterSendCell<cr>/# %%<cr>:noh<cr>", NS)
        map("i", "<S-cr>", "<esc>:JupyterSendCell<cr>/# %%<cr>:noh<cr>i", NS)

        map("n", "<leader>ms", "o# %%<cr><esc>", NS)
        map("n", "<leader>mS", "o# %%<cr><esc>kk", NS)
      end
    }

    use {
      "kdheepak/lazygit.nvim",
      setup = function()
        map("n", "<leader>og", ":LazyGit<cr>", NS)
      end,
      cmd = "LazyGit",
      config = function()
        cmd [[
        if has('nvim') && executable('nvr')
          let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
        endif
        ]]
      end
    }

    use {
      "famiu/bufdelete.nvim",
      event = "BufWinEnter",
      keys = {"n", "<leader>bk"},
      config = function()
        map("n", "<leader>bk", ":lua require('bufdelete').bufwipeout(0, true)<cr>", NS)
      end
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      requires = {
        "nvim-lua/plenary.nvim"
      },
      config = function()
        require "plugins.gitsigns"
      end
    }

    -- motion related
    use {
      "phaazon/hop.nvim",
      as = "hop",
      event = "BufWinEnter",
      -- cmd = {"HopLine", "HopWordBC", "HopWordAC", "HopChar1", "HopChar2"},
      -- keys = {{"x", "sl"}, {"x", "sk"}, {"x", "sj"}, {"x", "sf"}, {"x", "ss"}},
      setup = function()
        require "plugins.hop".init()
      end,
      config = function()
        require "plugins.hop".setup()
      end
    }
    use {
      "ggandor/lightspeed.nvim",
      event = "BufWinEnter",
      config = function()
        require("plugins.lightspeed")
      end
    }

    -- NOTE: can consider https://github.com/folke/persistence.nvim
    -- auto session
    use {
      "rmagatti/auto-session",
      event = "BufWinEnter",
      config = function()
        require("auto-session").setup()
      end
    }

    -- highlight search
    use {
      "rktjmp/highlight-current-n.nvim",
      keys = {{"n", "/"}, {"n", "*"}},
      config = function()
        map("n", "n", "<Plug>(highlight-current-n-n)zz", {})
        map("n", "N", "<Plug>(highlight-current-n-N)zz", {})
      end
    }

    -- correct python indentation
    use {
      "Vimjas/vim-python-pep8-indent",
      ft = "python"
    }

    -- Write Read without sudo permission
    use {
      "lambdalisue/suda.vim",
      cmd = {"SudaRead", "SudaWrite"}
    }
    -- use {
    --   "tweekmonster/startuptime.vim"
    -- }
  end
)
