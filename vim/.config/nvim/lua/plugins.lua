return require("packer").startup(
  function(use)
    use "wbthomason/packer.nvim"

    -- lsp
    use {
      "neovim/nvim-lspconfig",
      requires = {
        "kabouzeid/nvim-lspinstall"
      },
      config = function()
        require "plugins/lsp"
      end
    }

    -- completion
    use {
      "hrsh7th/nvim-compe",
      config = function()
        require "plugins/compe"
      end
    }

    -- theme
    use {"kwkarlwang/vim-dracula", as = "dracula"}

    -- comment function
    use "preservim/nerdcommenter"
    use {
      "hoob3rt/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true},
      config = function()
        require "plugins/lualine"
      end
    }

    -- for telescope
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        {"nvim-lua/popup.nvim"},
        {"nvim-lua/plenary.nvim"}
      },
      config = function()
        require "plugins/telescope"
      end
    }

    use "p00f/nvim-ts-rainbow"
    --------Tree Sitter-----------
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require "nvim-treesitter.configs".setup {
          ensure_installed = "maintained",
          ignore_install = {"haskell"},
          highlight = {enable = true},
          rainbow = {
            enable = false
          }
        }
      end
    }

    use "tpope/vim-surround"

    -- pair brackets
    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup {
          disable_filetype = {}
        }
        require("nvim-autopairs.completion.compe").setup(
          {
            map_cr = true, --  map <CR> on insert mode
            map_complete = true -- it will auto insert `(` after select function or method item
          }
        )
      end
    }

    -- git
    use {
      "tpope/vim-fugitive"
    }

    use {
      "TimUntersberger/neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("neogit").setup {}
        map("n", "<leader>gg", ":Neogit<cr>", {noremap = true})
      end
    }

    -- terminal
    use {
      "akinsho/nvim-toggleterm.lua",
      config = function()
        require "plugins/term"
      end
    }

    -- tree structure
    use {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require "plugins/tree"
      end
    }

    -- color hex code
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }

    -- change root to git repo
    use {
      "airblade/vim-rooter",
      config = function()
        g.rooter_manual_only = 1
      end
    }

    -- Formatter.nvim
    use {
      "mhartington/formatter.nvim",
      config = function()
        require "plugins/formatter"
      end
    }

    -- dashboard, disbale for now
    --use {
    --"glepnir/dashboard-nvim",
    --config = function()
    --require("plugins/dashboard")
    --end
    --}

    -- mutlicurosr
    use {
      "mg979/vim-visual-multi",
      config = function()
        cmd [[
            let g:VM_default_mappings = 0
            let g:VM_maps = {}
            let g:VM_maps['Find Under'] = '<M-d>'
            let g:VM_maps['Find Subword Under'] = '<M-d>'
            let g:VM_maps['Select All'] = '<C-M-d>'
            let g:VM_maps['Find Next'] = 'n'
            let g:VM_maps['Find Prev'] = 'N'
            let g:VM_maps["Undo"] = 'u'
            let g:VM_maps["Redo"] = '<C-r>'
            let g:VM_maps["Skip Region"] = '<cr>'
        ]]
      end
    }
  end
)
