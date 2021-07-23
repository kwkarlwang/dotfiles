g.dashboard_default_executive = "telescope"

map("n", "<leader>SS", "<C-u>SessionSave<cr>", {noremap = true})
map("n", "<leader>SL", "<C-u>SessionLoad<cr>", {noremap = true})
map("n", "<leader>fr", ":DashboardFindHistory<cr>", {noremap = true, silent = true})
map("n", "<leader><leader>", ":DashboardFindFile<cr>", {noremap = true, silent = true})
map("n", "<leader>tc", ":DashboardChangeColorscheme<cr>", {noremap = true, silent = true})
