require("lightspeed").setup({
	jump_to_first_match = true,
	jump_on_partial_input_safety_timeout = 400,
	-- This can get _really_ slow if the window has a lot of content,
	-- turn it on only if your machine can always cope with it.
	highlight_unique_chars = true,
	grey_out_search_area = true,
	match_only_the_start_of_same_char_seqs = true,
	limit_ft_matches = 10,
	full_inclusive_prefix_key = "<c-x>",
	-- instant_repeat_fwd_key = ";",
	-- instant_repeat_bwd_key = ",",
	-- By default, the values of these will be decided at runtime,
	-- based on `jump_to_first_match`.
	labels = nil,
	cycle_group_fwd_key = [[']],
	cycle_group_bwd_key = [["]],
})

function RepeatFt(reverse)
	local ls = require("lightspeed")
	ls.ft["instant-repeat?"] = true
	ls.ft:to(reverse, ls.ft["prev-t-like?"])
end
-- map("n", ";", "<cmd>lua RepeatFt(false)<cr>", NS)
-- map("x", ";", "<cmd>lua RepeatFt(false)<cr>", NS)
-- map("n", ",", "<cmd>lua RepeatFt(true)<cr>", NS)
-- map("x", ",", "<cmd>lua RepeatFt(true)<cr>", NS)
map("n", ";", "<Plug>Lightspeed_;_ft", {})
map("x", ";", "<Plug>Lightspeed_;_ft", {})
map("n", ",", "<Plug>Lightspeed_,_ft", {})
map("x", ",", "<Plug>Lightspeed_,_ft", {})

map("", [[']], "<Plug>Lightspeed_s", {})
map("", [["]], "<Plug>Lightspeed_S", {})
-- map("x", [[']], "<Plug>Lightspeed_s", {})
-- map("x", [["]], "<Plug>Lightspeed_S", {})
-- map("n", [[.]], "<Plug>Lightspeed_s<cr>", {})
-- map("", [[sh]], "<Plug>Lightspeed_S", {})
-- map("", [[sl]], "<Plug>Lightspeed_s", {})
-- cmd [[unmap s]]
cmd([[nunmap S]])
