local actions = require('telescope.actions')
require('telescope').setup{
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
        }
    }
}



map('n', '<leader><space>','<cmd>Telescope find_files<cr>', {noremap=true})
map('n', '<leader>sp', '<cmd>Telescope live_grep<cr>', {noremap=true})
--map('n', '<leader>sp', '<cmd>Telescope grep_string<cr>', {noremap=true})
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap=true})
map('n', '<leader>,', '<cmd>Telescope buffers<cr>', {noremap=true})


