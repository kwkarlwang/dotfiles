require("toggleterm").setup{
  size = 20,
  open_mapping = [[<leader>j]],
  --hide_numbers = true, -- hide the number column in toggleterm buffers
  --shade_filetypes = {},
  shade_terminals = false,
  --shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = false,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  --persist_size = true,
  --direction = 'vertical' | 'horizontal' | 'window' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  --shell = vim.o.shell, -- change the default shell
  ---- This field is only relevant if direction is set to 'float'
  --float_opts = {
    --border = 'curved',
    --width = ,
    --height = <value>,
    --winblend = 3,
    --highlights = {
      --border = "Normal",
      --background = "Normal",
    --}
  --}
}

