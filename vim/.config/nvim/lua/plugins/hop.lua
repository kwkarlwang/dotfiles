local M = {}
M.init = function()
  map("n", "sd", ":HopLineStart<cr>", NS)

  map("n", "ss", ":HopWord<cr>", NS)
  map("v", "ss", [[<cmd>lua require('hop').hint_words()<cr>]], NS)

  map("n", "sa", ":HopChar1<cr>", NS)
  map("v", "sa", [[<cmd>lua require('hop').hint_char1()<cr>]], NS)
  -- map("n", "f", ":HopChar1<cr>", NS)
  -- map("v", "f", [[<cmd>lua require('hop').hint_char1()<cr>]], NS)
  -- map("n", "F", "f", NS)
  -- map("v", "F", "f", NS)
end
M.setup = function()
  require "hop".setup {keys = "asdfhjkl"}
end
return M
