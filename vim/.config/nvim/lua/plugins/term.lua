require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return vim.fn.winheight(0) * 0.7
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<C-s>]],
  shade_terminals = false,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = "horizontal",
  close_on_exit = false -- close the terminal window when the process exits
  --shell = vim.o.shell, -- change the default shell
}
-- map("n", "<leader>j", ":ToggleTerm<cr>", {noremap = true, silent = true})
map("n", "<leader>ot", ":ToggleTerm direction=horizontal<cr>", {noremap = true, silent = true})
map("n", "<leader>ol", ":ToggleTerm direction=vertical<cr>", {noremap = true, silent = true})
