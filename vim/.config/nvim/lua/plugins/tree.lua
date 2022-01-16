local M = {}
M.setup = function()
	local tree_cb = require("nvim-tree.config").nvim_tree_callback
	local list = {
		{ key = { "h" }, cb = tree_cb("close_node") },
		{ key = { "o" }, cb = tree_cb("cd") },
		{ key = { "<CR>", "l" }, cb = tree_cb("edit") },
		{ key = "<C-v>", cb = tree_cb("vsplit") },
		{ key = "<C-x>", cb = tree_cb("split") },
		{ key = "<C-t>", cb = tree_cb("tabnew") },
		{ key = "<", cb = tree_cb("prev_sibling") },
		{ key = ">", cb = tree_cb("next_sibling") },
		{ key = "P", cb = tree_cb("parent_node") },
		{ key = "<BS>", cb = tree_cb("close_node") },
		{ key = "<Tab>", cb = tree_cb("preview") },
		{ key = "K", cb = tree_cb("first_sibling") },
		{ key = "J", cb = tree_cb("last_sibling") },
		{ key = "I", cb = tree_cb("toggle_ignored") },
		{ key = "H", cb = tree_cb("toggle_dotfiles") },
		{ key = "R", cb = tree_cb("refresh") },
		{ key = "a", cb = tree_cb("create") },
		{ key = "D", cb = tree_cb("trash") },
		{ key = "r", cb = tree_cb("rename") },
		{ key = "<C-r>", cb = tree_cb("full_rename") },
		{ key = "x", cb = tree_cb("cut") },
		{ key = "yy", cb = tree_cb("copy") },
		{ key = "p", cb = tree_cb("paste") },
		{ key = "yn", cb = tree_cb("copy_name") },
		{ key = "yp", cb = tree_cb("copy_path") },
		{ key = "yP", cb = tree_cb("copy_absolute_path") },
		{ key = "[c", cb = tree_cb("prev_git_item") },
		{ key = "]c", cb = tree_cb("next_git_item") },
		{ key = "-", cb = tree_cb("dir_up") },
		{ key = "q", cb = tree_cb("close") },
		{ key = "?", cb = tree_cb("toggle_help") },
	}

	g.nvim_tree_auto_close = 1
	g.nvim_tree_width = 40
	g.nvim_tree_auto_open = 0
	g.nvim_tree_quit_on_open = 1
	g.nvim_tree_follow = 1

	-- netrw, 1 is disable
	g.nvim_tree_disable_netrw = 0
	g.nvim_tree_hijack_netrw = 0
	require("nvim-tree").setup({
		view = {
			mappings = {
				custom_only = true,
				list = list,
			},
		},
	})
end
M.init = function()
	map("n", "<leader>op", ":NvimTreeToggle<cr>", { noremap = true, silent = true })
end
return M
