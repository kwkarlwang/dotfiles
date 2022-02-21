local M = {}
local canSetCursorline = true
M.setup = function()
	vim.cmd([[
augroup CursorLine
  autocmd!
  autocmd BufEnter,WinEnter * lua require('plugins.cursorline').set_cursorline(true)
  autocmd BufLeave,WinLeave * lua require('plugins.cursorline').set_cursorline(false)
  autocmd FileType TelescopePrompt lua require('plugins.cursorline').block_set_cursorline(true)
  autocmd FileType TelescopePrompt autocmd BufLeave <buffer> lua require('plugins.cursorline').block_set_cursorline(false)
augroup END
]])
end
M.set_cursorline = function(set)
	if canSetCursorline == false then
		return
	end
	if set == true then
		vim.cmd("setlocal cursorline")
	else
		vim.cmd("setlocal nocursorline")
	end
end

M.block_set_cursorline = function(block)
	if block then
		M.set_cursorline(false)
	end
	canSetCursorline = not block
end
return M
