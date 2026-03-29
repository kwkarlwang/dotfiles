local silent = { silent = true }

---@param command_id string
local vscode_cmd = function(command_id)
	return "<Cmd>call VSCodeNotify('" .. command_id .. "')<CR>"
end

vim.keymap.set("", "<Space>", "<Nop>")
g.mapleader = " "
o.clipboard = "unnamedplus"
o.smartcase = true
o.ignorecase = true
-- o.timeoutlen = 400

map("n", "j", "gj", NS)
map("n", "k", "gk", NS)
map("n", "<Esc>", ":noh<cr>" .. vscode_cmd("notifications.clearAll"), NS)
map("v", "<", "<gv", NS)
map("v", ">", ">gv", NS)
map("i", "jk", "<Esc>", NS)

map("n", "s", "<nop>", NS)

map("v", "y", "ygv<esc>", NS)

map("n", "*", "*Nn", silent)
map("n", "#", "#Nn", silent)
map("n", "gf", "*N", silent)

-- Move to first and end
map("n", "H", "g^", NS)
map("n", "L", "g$", NS)
map("x", "H", "g^", NS)
map("x", "L", "g$", NS)

map("n", "Q", "q", NS)
map("n", "q", "%", NS)
map("x", "q", "%", NS)
map("v", "q", "%", NS)

-- Add ; to end of the line
-- doesn't work in vscode
map("n", "<C-;>", "m`A;<esc>``", NS)
map("i", "<C-;>", "<C-o>m`<C-o>A;<esc>``", NS)

map("n", "<C-,>", "m`A,<esc>``", NS)
map("i", "<C-,>", "<C-o>m`<C-o>A,<esc>``", NS)

-- select non blank line
map("n", "vv", "^vg_", NS)

-- begin and end of line in insert mode
map("i", "<C-q>", "<C-o>I", NS)
map("i", "<C-e>", "<C-o>A", NS)

-- WINDOWS
map("n", "<leader>wd", vscode_cmd("workbench.action.closeEditorsAndGroup"), silent)
map("n", "<leader>w", "<C-w>", silent)
map("n", "<leader>wo", vscode_cmd("workbench.action.toggleMaximizeEditorGroup"), NS)

-- navigation
map("n", "dh", "<C-w>h", silent)
map("n", "dj", "<C-w>j", silent)
map("n", "dk", "<C-w>k", silent)
map("n", "dl", "<C-w>l", silent)
map("n", "sd", vscode_cmd("workbench.action.closeEditorsAndGroup"), silent)

map("n", "]e", vscode_cmd("editor.action.marker.next"), NS)
map("n", "[e", vscode_cmd("editor.action.marker.prev"), NS)

-- git opertaions
map("n", "]h", vscode_cmd("editor.action.dirtydiff.next"), NS)
map("n", "[h", vscode_cmd("editor.action.dirtydiff.previous"), NS)
map("n", "<leader>hr", vscode_cmd("git.revertSelectedRanges"), NS)
map("n", "<leader>hR", vscode_cmd("git.clean"), NS)
map("n", "<leader>hs", vscode_cmd("git.stageSelectedRanges"), NS)
map("n", "<leader>hS", vscode_cmd("git.stageFile"), NS)
map("n", "<leader>hu", vscode_cmd("git.unstageSelectedRanges"), NS)
map("n", "<leader>hU", vscode_cmd("git.unstageFile"), NS)
map("n", "<leader>tb", vscode_cmd("git.blame.toggleEditorDecoration"), NS)

-- file operations
map("", "<leader><leader>", vscode_cmd("workbench.action.quickOpen"), NS)
map("n", "<leader>,", vscode_cmd("workbench.action.quickOpen"), NS)
map("n", "<leader>.", vscode_cmd("yazi-vscode.toggle"), NS)
map("n", "<leader>sp", vscode_cmd("workbench.action.quickTextSearch"), NS)
map("n", "<leader>gf", "viw" .. vscode_cmd("workbench.action.quickTextSearch"), NS)

-- code action
map("n", "<leader>ca", vscode_cmd("editor.action.quickFix"), NS)
map("n", "<leader>cf", vscode_cmd("editor.action.formatDocument"), NS)
map("n", "ss", vscode_cmd("editor.action.formatDocument"), NS)
map("n", "<leader>ls", vscode_cmd("workbench.action.gotoSymbol"), NS)
map("n", "<leader>cr", vscode_cmd("editor.action.rename"), NS)
