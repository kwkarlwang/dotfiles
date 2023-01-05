-- replace UI for messages, cmdline, and popupmenu
local routes = vim.tbl_map(function(pair)
	return {
		filter = {
			find = pair[1],
		},
		opts = { skip = true },
		view = pair[2],
	}
end, {
	{ "written$", "notify" },
	{ "yanked", "notify" },
	{ "line less", "notify" },
	{ "fewer line", "notify" },
	{ "more line", "notify" },
	{ "attempt", "notify" },
	{ "Error executing vim.schedule lua callback", "notify" },
	{ "change", "notify" },
	{ "formatting", "mini" },
	{ "Building jdtls", "mini" },
	{ "Validate documents jdtls", "mini" },
	{ "Publish Diagnostics jdtls", "mini" },
	{ "Refreshing workspace jdtls", "mini" },
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
				progress = {
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
	end,
}
