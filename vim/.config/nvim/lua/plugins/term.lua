require("toggleterm").setup {
  size = 20,
  open_mapping = [[<leader>j]],
  shade_terminals = false,
  start_in_insert = false,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  --persist_size = true,
  --direction = 'vertical' | 'horizontal' | 'window' | 'float',
  close_on_exit = true -- close the terminal window when the process exits
  --shell = vim.o.shell, -- change the default shell
}
map("n", "<leader>ot", ":ToggleTerm<cr>", {noremap = true, silent = true})
