local getFiletypeComment = function()
	local ft = require("Comment.ft")
	local U = require("Comment.utils")
	local current_filetype = vim.bo.filetype
	return ft.get(current_filetype, U.ctype.linewise)
end

local M = {}
M.commentWithOpenIdentifier = function()
	return getFiletypeComment():gsub("%%s", " >>>")
end

M.commentWithCloseIdentifier = function()
	return getFiletypeComment():gsub("%%s", " <<<")
end
return M
