---@return string
local get_filetype_comment = function()
	local ft = require("Comment.ft")
	local U = require("Comment.utils")
	local current_filetype = vim.bo.filetype
	return ft.get(current_filetype, U.ctype.linewise)
end

local M = {}
M.comment_with_open_identifier = function()
	return get_filetype_comment():gsub("%%s", " >>>")
end

M.comment_with_close_identifier = function()
	return get_filetype_comment():gsub("%%s", " <<<")
end

M.get_rust_impl_name = function()
	local parser = vim.treesitter.get_parser()
	local syntax_tree = parser:parse()[1]
	local root = syntax_tree:root()
	local query_string = [[((impl_item (type_identifier) @impl_name))]]
	local query = vim.treesitter.query.parse("rust", query_string)
	-- get the last impl name
	local last_impl_name = ""
	for _, captures, _ in query:iter_matches(root, 0) do
		last_impl_name = vim.treesitter.get_node_text(captures[1], 0)
	end
	return last_impl_name
end

return M
