return {
	"NeogitOrg/neogit",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Neogit",
	keys = { { "<leader>gg", "<cmd>Neogit<cr>" } },
	config = function()
		require("neogit").setup({
			disable_hint = true,
			disable_context_highlighting = true,
			disable_commit_confirmation = true,
			disable_commit_notifications = true,
			integrations = {
				diffview = true,
			},
			sections = {
				untracked = {
					folded = false,
					hidden = false,
				},
				unstaged = {
					folded = false,
					hidden = false,
				},
				staged = {
					folded = false,
					hidden = false,
				},
				stashes = {
					folded = false,
					hidden = false,
				},
				unpulled_upstream = {
					folded = false,
					hidden = false,
				},
				unmerged_upstream = {
					folded = false,
					hidden = false,
				},
				unpulled_pushRemote = {
					folded = false,
					hidden = false,
				},
				unmerged_pushRemote = {
					folded = false,
					hidden = false,
				},
				recent = {
					folded = false,
					hidden = false,
				},
			},
			mappings = {
				popup = { ["p"] = "PushPopup", ["F"] = "PullPopup" },
			},
		})
		vim.cmd([[
    hi! link NeogitDiffAdd DiffAdd
    hi! link NeogitDiffDelete DiffDelete
    hi NeogitDiffContext guibg=#1E2029
    ]])
	end,
}
