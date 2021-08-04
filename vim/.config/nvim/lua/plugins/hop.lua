local M = {}
M.init = function()
  map("n", "sd", ":HopLineStart<cr>", NS)
  map("n", "ss", ":HopWord<cr>", NS)
end
M.setup = function()
  require "hop".setup {keys = "asdfhjklcnm;'"}
end
return M
