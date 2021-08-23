local M = {}
M.init = function()
  map("n", "sK", ":HopLineBC<cr>", NS)
  map("x", "sK", [[<cmd>lua require('hop').hint_lines({direction=1})<cr>]], NS)
  map("n", "sJ", ":HopLineAC<cr>", NS)
  map("x", "sJ", [[<cmd>lua require('hop').hint_lines({direction=2})<cr>]], NS)

  map("n", "sk", ":HopWordBC<cr>", NS)
  map("n", "sj", ":HopWordAC<cr>", NS)
  map("x", "sk", [[<cmd>lua require('hop').hint_words({direction=1})<cr>]], NS)
  map("x", "sj", [[<cmd>lua require('hop').hint_words({direction=2})<cr>]], NS)

  -- map("n", "sf", ":HopChar1<cr>", NS)
  -- map("n", "ss", ":HopChar2<cr>", NS)
  -- map("x", "sf", [[<cmd>lua require('hop').hint_char1()<cr>]], NS)
  -- map("x", "ss", [[<cmd>lua require('hop').hint_char2()<cr>]], NS)
end
M.setup = function()
  require "hop".setup {
    keys = "asdghklcvnmfj"
  }
end
return M
