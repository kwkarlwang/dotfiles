local actions = require("telescope.actions")
require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden"
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-c>"] = false
      }
    },
    file_ignore_patterns = {"node_modules", ".git"}
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer
        }
      },
      theme = "ivy"
    },
    find_files = {
      previewer = false,
      theme = "ivy",
      hidden = true
    },
    current_buffer_fuzzy_find = {
      theme = "ivy",
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--fixed-strings"
      }
    },
    -- TODO: can revise to looklike counsel
    file_browser = {
      theme = "ivy"
    },
    oldfiles = {
      theme = "ivy"
    },
    commands = {
      theme = "ivy"
    },
    lsp_references = {
      theme = "ivy"
    },
    lsp_definitions = {
      theme = "ivy"
    },
    help_tags = {
      theme = "ivy"
    },
    live_grep = {}
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true
    }
  }
}

local opts = {noremap = true, silent = true}
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fp", "<cmd>Telescope find_files search_dirs=~/.config/nvim<cr>", opts)
map("n", "<leader>sp", "<cmd>Telescope live_grep hidden=true<cr>", opts)
map("n", "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)

map("n", "<leader>hh", "<cmd>Telescope help_tags<cr>", opts)

map("n", "<leader>,", "<cmd>Telescope buffers<cr>", opts)

map("n", "<M-x>", "<cmd>Telescope commands<cr>", opts)
map("n", "<leader>:", "<cmd>Telescope commands<cr>", opts)
-- index into current directory
map("n", "<leader>.", ":lua require('telescope.builtin').file_browser({cwd=vim.fn.expand('%:p:h')})<cr>", opts)
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", opts)

map("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)
map("n", "gD", "<Cmd>Telescope lsp_references<CR>", opts)

require("telescope").load_extension("fzy_native")
