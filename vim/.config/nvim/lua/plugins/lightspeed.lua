return {
	"ggandor/lightspeed.nvim",
	init = function()
		g.lightspeed_no_default_keymaps = true
	end,
	config = function()
		require("lightspeed").setup({
			ignore_case = true,
			match_only_the_start_of_same_char_seqs = true,
			limit_ft_matches = 10,
			labels = nil,
			special_keys = {
				next_match_group = "<space>",
				prev_match_group = "<tab>",
			},
			exit_after_idle_msecs = { labeled = nil, unlabeled = nil },
		})

		map("n", [[']], "<Plug>Lightspeed_s", {})
		map("n", [["]], "<Plug>Lightspeed_S", {})
		map("x", [[']], "<Plug>Lightspeed_s", {})
		map("x", [["]], "<Plug>Lightspeed_S", {})
		map("n", [[f]], "<Plug>Lightspeed_f", {})
		map("n", [[F]], "<Plug>Lightspeed_F", {})
		map("x", [[f]], "<Plug>Lightspeed_f", {})
		map("x", [[F]], "<Plug>Lightspeed_f", {})
		map("n", [[t]], "<Plug>Lightspeed_t", {})
		map("n", [[T]], "<Plug>Lightspeed_T", {})
		map("x", [[t]], "<Plug>Lightspeed_t", {})
		map("x", [[T]], "<Plug>Lightspeed_T", {})
		vim.cmd([[
		let g:lightspeed_last_motion = ''
		augroup lightspeed_last_motion
		autocmd!
		autocmd User LightspeedSxEnter let g:lightspeed_last_motion = 'sx'
		autocmd User LightspeedFtEnter let g:lightspeed_last_motion = 'ft'
		augroup end
		map <expr> ; g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>Lightspeed_;_ft"
		map <expr> , g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>Lightspeed_,_ft"
		]])
		-- cmd([[
		-- nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
		-- nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
		-- nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
		-- nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"
		-- ]])
	end,
}
