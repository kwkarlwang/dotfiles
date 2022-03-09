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
		local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
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
		api.toggle_current_linewise(config)
		vim.api.nvim_feedkeys("==A ", "n", true)
	else
		api.toggle_current_linewise()
	end
end
map("n", "cc", "<cmd>lua ToggleLine()<cr>", NS)
map("n", "cb", '<cmd>lua require("Comment.api").toggle_current_blockwise()<cr>', NS)
map("x", "cc", '<esc><cmd>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<cr>', NS)
map("x", "cb", '<esc><cmd>lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())<cr>', NS)
