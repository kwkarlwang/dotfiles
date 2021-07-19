return require('packer').startup(function(use)

  use "wbthomason/packer.nvim"

  -- lsp
  use  { "neovim/nvim-lspconfig",
    config=function()
      require "plugins/lsp"
    end
  }
  use  {"hrsh7th/nvim-compe",
    config=function()
      require "plugins/compe"
    end
  }

  use  {"kwkarlwang/vim-dracula", as="dracula"}

  -- comment function
  use  "preservim/nerdcommenter"
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config=function()
      require 'plugins/lualine'
    end
  }

  -- for telescope
  use  { "nvim-telescope/telescope.nvim",
    requires={
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" }    
    },
    config=function()
        require 'plugins/telescope'
    end
  }


  
  use "p00f/nvim-ts-rainbow"
  --------Tree Sitter-----------
  use  {"nvim-treesitter/nvim-treesitter",
    run=":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup { 
        ensure_installed = "maintained",
        ignore_install = {"haskell"},
        highlight = { enable = true },
        rainbow = {
          enable = false
        }
      }
    end
  }

  use  "tpope/vim-surround"

  -- pair brackets 
  use {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup {
         disable_filetype = {},
      }
    end
  }

  -- fugitive
  use 'tpope/vim-fugitive'

  use {"akinsho/nvim-toggleterm.lua",
    config = function()
        require 'plugins/term'
    end
  }

end)
