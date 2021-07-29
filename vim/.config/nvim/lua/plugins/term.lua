require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<C-t>]],
  shade_terminals = false,
  start_in_insert = false,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = "horizontal",
  close_on_exit = false -- close the terminal window when the process exits
  --shell = vim.o.shell, -- change the default shell
}
map("n", "<leader>ot", ":ToggleTerm<cr>", {noremap = true, silent = true})
map("n", "<leader>j", ":ToggleTerm direction=horizontal<cr>", {noremap = true, silent = true})
map("n", "<leader>J", ":ToggleTerm direction=vertical<cr>", {noremap = true, silent = true})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit =
  Terminal:new(
  {
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "double"
    },
    -- function to run on opening the terminal
    on_open = function(term)
      cmd("startinsert!")
      bufmap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end
    -- function to run on closing the terminal
    -- on_close = function(term)
    --     cmd("Closing terminal")
    -- end
  }
)

function _lazygit_toggle()
  lazygit:toggle()
end

map("n", "<leader>G", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
