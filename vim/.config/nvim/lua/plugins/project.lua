g.nvim_tree_update_cwd = 1
g.nvim_tree_update_buf_cwd = 1

require("project_nvim").setup(
  {
    -- Manual mode doesn't automatically change your root directory, so you have
    -- the option to manually do so using `:ProjectRoot` command.
    manual_mode = true,
    -- Methods of detecting the root directory. **"lsp"** uses the native neovim
    -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
    -- order matters: if one is not detected, the other is used as fallback. You
    -- can also delete or rearangne the detection methods.
    detection_methods = {"lsp", "pattern"},
    -- All the patterns used to detect root dir, when **"pattern"** is in
    -- detection_methods
    patterns = {".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".editorconfig"},
    -- Table of lsp clients to ignore by name
    -- eg: { "efm", ... }
    ignore_lsp = {},
    -- When set to false, you will get a message when project.nvim changes your
    -- directory.
    silent_chdir = true,
    -- Path where project.nvim will store the project history for use in
    -- telescope
    datapath = vim.fn.stdpath("data")
  }
)
