return {
	"ggandor/leap.nvim",
	enabled = false,
	dependencies = {
		{ "ggandor/flit.nvim", config = true },
	},
	config = function()
		-- local opts = require("leap").opts
		-- opts.highlight_unlabeled_phase_one_targets = true
		-- require("leap").setup(opts)

		vim.keymap.set({ "n", "x", "o" }, [[']], "<Plug>(leap-forward-to)")
		vim.keymap.set({ "n", "x", "o" }, [["]], "<Plug>(leap-backward-to)")

		local function set_leap_repeat_keys(repeat_key, revert_key)
			local spec_keys = require("leap").opts.special_keys

			local function switch_next_prev()
				local temp = spec_keys["next_target"]
				spec_keys["next_target"] = spec_keys["prev_target"]
				-- Note: I'm thinking about removing `repeat_search`, and merging it with `next_target`.
				spec_keys["repeat_search"] = spec_keys["prev_target"]
				spec_keys["prev_target"] = temp
			end

			spec_keys["repeat_search"] = repeat_key
			spec_keys["next_target"] = repeat_key
			spec_keys["prev_target"] = revert_key

			vim.keymap.set({ "n", "x", "o" }, repeat_key, "<Plug>(leap-forward-to)" .. repeat_key)

			vim.keymap.set({ "n", "x", "o" }, revert_key, function()
				vim.g.reverse_leap = true
				return ("<Plug>(leap-backward-to)" .. revert_key)
			end, { expr = true })

			vim.api.nvim_create_augroup("LeapCustom", {})

			vim.api.nvim_create_autocmd("User", {
				pattern = "LeapEnter",
				group = "LeapCustom",
				callback = function()
					if vim.g.reverse_leap then
						switch_next_prev()
					end
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "LeapLeave",
				group = "LeapCustom",
				callback = function()
					if vim.g.reverse_leap then
						switch_next_prev()
						vim.g.reverse_leap = nil
					end
				end,
			})
		end

		-- Use it like:
		-- set_leap_repeat_keys(";", ",")
	end,
}
