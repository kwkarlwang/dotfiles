local M = {}
M.init = function()
	map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", NS)
	map("n", "<leader>dB", "<cmd>lua require'dap'.step_back()<cr>", NS)
	map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", NS)
	map("n", "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", NS)
	map("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", NS)
	map("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>", NS)
	map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", NS)
	map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", NS)
	map("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", NS)
	map("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", NS)
	map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", NS)
	map("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", NS)
	map("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", NS)
end

M.config = function()
	local dap = require("dap")
	dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = home_dir .. ".local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
	}
end
return M
