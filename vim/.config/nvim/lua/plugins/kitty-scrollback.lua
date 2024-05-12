return {
	"mikesmithgh/kitty-scrollback.nvim",
	lazy = true,
	cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
	event = { "User KittyScrollbackLaunch" },
	-- version = '*', -- latest stable version, may have breaking changes if major version changed
	-- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
	config = function()
		require("kitty-scrollback").setup({
			-- global configurations
			{
				visual_selection_highlight_mode = "nvim",
				keymaps_enabled = false,
				callbacks = {
					after_launch = function()
						local api = require("kitty-scrollback.api")
						vim.keymap.set("n", "q", api.close_or_quit_all, { buffer = 0 })
						-- bufmap(0, "n", "<Esc>", ":noh<cr><cmd>lua require('notify').dismiss()<cr>", NS)
						vim.opt.winbar = ""
						vim.opt.signcolumn = "no"
					end,
				},
				status_window = { enabled = false },
				paste_window = {
					yank_register_enabled = false,
					hide_footer = true,
				},
			},
			ksb_builtin_get_text_all = {
				kitty_get_text = {
					extent = "all",
					ansi = true,
				},
			},
			get_last_non_empty_output = {
				kitty_get_text = {
					extent = "last_non_empty_output",
					ansi = true,
				},
				callbacks = {
					after_ready = function()
						vim.api.nvim_feedkeys("G{}", "n", true)
					end,
				},
			},
		})
	end,
}
