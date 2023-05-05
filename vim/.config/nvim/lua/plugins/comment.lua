local M = {
	"numToStr/Comment.nvim",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				require("nvim-treesitter.configs").setup({
					context_commentstring = {
						enable = true,
						enable_autocmd = false,
					},
				})
			end,
		},
	},
}
M.config = function()
	local api = require("Comment.api")
	local config = {
		padding = true,
		sticky = true,
		ignore = "^$",
		toggler = {
			line = "cc",
			block = "cb",
		},
		pre_hook = function(ctx)
			if vim.bo.filetype ~= "typescriptreact" and vim.bo.filetype ~= "javascriptreact" then
				return
			end
			local U = require("Comment.utils")
			-- Detemine whether to use linewise or blockwise commentstring
			local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"
			-- Determine the location where to calculate commentstring from
			local location = nil
			if ctx.ctype == U.ctype.block then
				location = require("ts_context_commentstring.utils").get_cursor_location()
			elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				location = require("ts_context_commentstring.utils").get_visual_start_location()
			end

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = type,
				location = location,
			})
		end,
	}
	require("Comment").setup(config)
	config.ignore = nil
	ToggleLine = function()
		local currline = vim.api.nvim_get_current_line()
		if currline == "" then
			api.toggle.linewise.current(nil, config)
			vim.api.nvim_feedkeys("==A ", "n", true)
		else
			api.toggle.linewise.current()
		end
	end
	map("n", "cc", "<cmd>lua ToggleLine()<cr>", NS)
	map("n", "cb", '<cmd>lua require("Comment.api").toggle.blockwise.current()<cr>', NS)
	map("x", "cc", '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>', NS)
	map("x", "cb", '<esc><cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<cr>', NS)
end
return M
