require "lightspeed".setup {
  jump_to_first_match = true,
  jump_on_partial_input_safety_timeout = 400,
  -- This can get _really_ slow if the window has a lot of content,
  -- turn it on only if your machine can always cope with it.
  highlight_unique_chars = true,
  grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 10,
  full_inclusive_prefix_key = "<c-x>",
  -- By default, the values of these will be decided at runtime,
  -- based on `jump_to_first_match`.
  labels = nil,
  cycle_group_fwd_key = nil,
  cycle_group_bwd_key = nil
}

function repeat_ft(reverse)
  local ls = require "lightspeed"
  ls.ft["instant-repeat?"] = true
  ls.ft:to(reverse, ls.ft["prev-t-like?"])
end
map("n", ";", "<cmd>lua repeat_ft(false)<cr>", NS)
map("x", ";", "<cmd>lua repeat_ft(false)<cr>", NS)
map("n", ",", "<cmd>lua repeat_ft(true)<cr>", NS)
map("x", ",", "<cmd>lua repeat_ft(true)<cr>", NS)
-- map("n", "<leader>j", "<Plug>Lightspeed_s", {})
-- map("n", "<leader>k", "<Plug>Lightspeed_S", {})

cmd [[unmap s]]