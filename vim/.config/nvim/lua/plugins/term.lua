require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 20
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<leader>j]],
  shade_terminals = false,
  start_in_insert = false,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = "vertical",
  close_on_exit = true -- close the terminal window when the process exits
  --shell = vim.o.shell, -- change the default shell
}
map("n", "<leader>ot", ":ToggleTerm<cr>", {noremap = true, silent = true})
map("t", "<Esc><leader>j", "<C-\\><C-n>:ToggleTerm<cr>", {noremap = true, silent = true})
