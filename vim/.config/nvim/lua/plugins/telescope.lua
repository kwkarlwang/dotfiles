local actions = require("telescope.actions")
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer
        }
      }
    }
  }
}

map("n", "<leader><space>", "<cmd>Telescope find_files hidden=true<cr>", {noremap = true})
map("n", "<leader>sp", "<cmd>Telescope live_grep<cr>", {noremap = true})
map("n", "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", {noremap = true})
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {noremap = true})
map("n", "<leader>,", "<cmd>Telescope buffers<cr>", {noremap = true})
map("n", "<M-x>", "<cmd>Telescope commands<cr>", {noremap = true})
map("n", "<leader>:", "<cmd>Telescope commands<cr>", {noremap = true})
map("n", "<leader>.", "<cmd>Telescope file_browser<cr>", {noremap = true})
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", {noremap = true})
