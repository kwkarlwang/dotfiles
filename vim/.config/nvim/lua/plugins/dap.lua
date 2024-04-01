return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("dapui").setup()
			end,
			dependencies = { "nvim-neotest/nvim-nio" },
		},
		{
			"mfussenegger/nvim-dap-python",
			config = function()
				require("dap-python").setup("python3")
			end,
		},
	},
	keys = {
		{ "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>" },
		{ "<leader>dB", "<cmd>lua require'dap'.step_back()<cr>" },
		-- { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>" },
		{ "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>" },
		{ "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr><cmd>lua require'dapui'.close()<cr>" },
		{ "<leader>dg", "<cmd>lua require'dap'.session()<cr>" },
		{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>" },
		-- { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>" },
		{ "<leader>du", "<cmd>lua require'dap'.step_out()<cr>" },
		{ "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>" },
		{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>" },
		{ "<leader>ds", "<cmd>lua require'dap'.continue()<cr>" },
		{ "<leader>dq", "<cmd>lua require'dap'.close()<cr>" },
	},
	config = function()
		local dap = require("dap")
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = home_dir .. ".local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		}

		local dapui = require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		-- dap.listeners.before.event_terminated["dapui_config"] = function()
		-- 	dapui.close()
		-- end
		-- dap.listeners.before.event_exited["dapui_config"] = function()
		-- 	dapui.close()
		-- end
	end,
}
