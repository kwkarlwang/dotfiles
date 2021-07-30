g.slime_target = "neovim"
-- g.slime_python_ipython = 1
g.slime_dont_ask_default = 1
map("n", "<C-cr>", ":IPythonCellExecuteCell<cr>", {noremap = true, silent = true})
map("n", "<S-cr>", ":IPythonCellExecuteCellJump<cr>", {noremap = true, silent = true})
map("n", "<leader>ms", ":IPythonCellInsertBelow<cr>", {noremap = true, silent = true})
map("n", "<leader>mm", ":IPythonCellToMarkdown<cr>", {noremap = true, silent = true})
map("n", "[c", ":IPythonCellPrevCell<cr>", {noremap = true, silent = true})
map("n", "]c", ":IPythonCellNextCell<cr>", {noremap = true, silent = true})

cmd [[
function! IPythonOpen()
    " open a new terminal in vertical split and run IPython
    vnew|call termopen('ipython --matplotlib')
    file ipython " name the new buffer

    " set slime target to new terminal
    if !exists('g:slime_default_config')
        let g:slime_default_config = {}
    end
    let g:slime_default_config['jobid'] = b:terminal_job_id

    wincmd p " switch to the previous buffer
endfunction
nnoremap <silent> <leader>mn :call IPythonOpen()<cr>
]]
