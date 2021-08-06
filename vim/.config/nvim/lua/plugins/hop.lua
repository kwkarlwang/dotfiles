local M = {}
M.init = function()
  map("n", "sl", ":HopLine<cr>", NS)

  map("n", "sk", ":HopWordBC<cr>", NS)
  map("n", "sj", ":HopWordAC<cr>", NS)
  -- map("v", "ss", [[<cmd>lua require('hop').hint_words()<cr>]], NS)

  map("n", "sf", ":HopChar1<cr>", NS)
  map("n", "ss", ":HopChar2<cr>", NS)
  -- map("v", "sa", [[<cmd>lua require('hop').hint_char1()<cr>]], NS)

  -- map("n", "f", ":HopChar1<cr>", NS)
  -- map("v", "f", [[<cmd>lua require('hop').hint_char1()<cr>]], NS)
  -- map("n", "F", "f", NS)
  -- map("v", "F", "f", NS)
end
M.setup = function()
  require "hop".setup {keys = "asdfhjkl"}
end
return M
