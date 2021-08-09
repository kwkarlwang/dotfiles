local M = {}
M.init = function()
  map("n", "sl", ":HopLine<cr>", NS)
  map("n", "sl", ":HopLine<cr>", NS)
  map("v", "<leader>l", [[<cmd>lua require('hop').hint_lines()<cr>]], NS)

  map("n", "sk", ":HopWordBC<cr>", NS)
  map("n", "sj", ":HopWordAC<cr>", NS)
  map("v", "<leader>k", [[<cmd>lua require('hop').hint_words({direction=1})<cr>]], NS)
  map("v", "<leader>j", [[<cmd>lua require('hop').hint_words({direction=2})<cr>]], NS)

  map("n", "sf", ":HopChar1<cr>", NS)
  map("n", "ss", ":HopChar2<cr>", NS)
  map("v", "<leader>f", [[<cmd>lua require('hop').hint_char1()<cr>]], NS)
  map("v", "<leader>s", [[<cmd>lua require('hop').hint_char2()<cr>]], NS)

  -- map("n", "f", ":HopChar1<cr>", NS)
  -- map("v", "f", [[<cmd>lua require('hop').hint_char1()<cr>]], NS)
  -- map("n", "F", "f", NS)
  -- map("v", "F", "f", NS)
end
M.setup = function()
  require "hop".setup {keys = "asdfhjkl"}
end
return M
