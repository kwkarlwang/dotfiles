-- replace UI for messages, cmdline, and popupmenu
local routes = vim.tbl_map(function(keyword)
	return {
		filter = {
			find = keyword,
		},
		opts = { skip = true },
	}
end, {
	"<",
	"written",
	"yanked",
	"second",
	"line",
	"change",
	"formatting",
	"jdtls",
})
table.insert(routes, {
	filter = {
		event = "msg_showmode",
	},
	view = "notify",
})
return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					-- jdtls hover doc does not support noice hover
					enabled = false,
				},
			},
			routes = routes,
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		})
		map("n", "<Esc>", "<cmd>noh<cr><cmd>lua require('notify').dismiss()<cr>", NS)
	end,
}
