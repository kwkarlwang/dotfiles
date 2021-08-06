local M = {}
M.setup = function()
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
      file_ignore_patterns = {"node_modules/", ".git/", ".gitmodules/", "cache"}
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
      live_grep = {
        hidden = true
      }
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true
      }
    }
  }
  require("telescope").load_extension("fzy_native")
end
M.init = function()
  map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", NS)
  map("n", "<leader>ff", "<cmd>Telescope find_files find_command=fd,--no-ignore,--hidden<cr>", NS)
  map("n", "<leader>fp", "<cmd>Telescope find_files search_dirs=~/.config/nvim<cr>", NS)

  map("n", "<leader>sp", "<cmd>Telescope live_grep<cr>", NS)
  map("n", "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", NS)

  map("n", "<leader>hh", "<cmd>Telescope help_tags<cr>", NS)

  map("n", "<leader>,", "<cmd>Telescope buffers<cr>", NS)

  map("n", "<M-x>", "<cmd>Telescope commands<cr>", NS)
  map("n", "<leader>:", "<cmd>Telescope commands<cr>", NS)
  map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", NS)

  map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", NS)
  map("n", "gD", "<cmd>Telescope lsp_references<CR>", NS)

  map("n", "<leader>sd", "<cmd>Telescope lsp_workspace_diagnostics<cr>", NS)
end
return M
