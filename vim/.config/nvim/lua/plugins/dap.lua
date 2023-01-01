return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("dapui").setup()
			end,
		},
	},
	keys = {
		{ "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>" },
		{ "<leader>dB", "<cmd>lua require'dap'.step_back()<cr>" },
		{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>" },
		{ "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>" },
		{ "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>" },
		{ "<leader>dg", "<cmd>lua require'dap'.session()<cr>" },
		{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>" },
		{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>" },
		{ "<leader>du", "<cmd>lua require'dap'.step_out()<cr>" },
		{ "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>" },
		{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>" },
		{ "<leader>ds", "<cmd>lua require'dap'.continue()<cr>" },
		{ "<leader>dq", "<cmd>lua require'dap'.close()<cr>" },
	},
	config = function()
		local dap = require("dap")
		dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = home_dir .. ".local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		}
	end,
}
