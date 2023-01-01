ToggleTerm = function(direction)
	local isOpen = function()
		local comparator = function(buf)
			return vim.bo[buf].filetype == "toggleterm"
		end

		local wins = api.nvim_list_wins()
		for _, win in pairs(wins) do
			local buf = vim.api.nvim_win_get_buf(win)
			if comparator(buf) then
				return true
			end
		end
		return false
	end
	local command = "ToggleTerm"
	if direction ~= nil then
		command = command .. " direction=" .. direction
	end
	if isOpen() then
		require("bufresize").block_register()
		vim.api.nvim_command(command)
		require("bufresize").resize_close()
	else
		require("bufresize").block_register()
		vim.api.nvim_command(command)
		require("bufresize").resize_open()
		vim.cmd([[execute "normal! i"]])
	end
end

return {
	"akinsho/nvim-toggleterm.lua",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<C-s>", "<cmd>lua ToggleTerm()<cr>" },
		{ "<leader>ot", [[<cmd>lua ToggleTerm("horizontal")<cr>]] },
		{ "<leader>ol", [[<cmd>lua ToggleTerm("vertical")<cr>]] },
		{ "<leader>of", [[<cmd>lua ToggleTerm("float")<cr>]] },
		{ "<leader>ol", [[<cmd>lua ToggleTerm("vertical")<cr>]] },

		{ "<leader>of", [[<cmd>lua ToggleTerm("float")<cr>]] },

		{ "<C-s>", "<C-o><cmd>lua ToggleTerm()<cr>", mode = "i" },
		{ "<C-s>", "<C-\\><C-n><cmd>lua ToggleTerm()<cr>", mode = "t" },
	},
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					-- return vim.fn.winheight(0) * 0.7
					return 20
				elseif term.direction == "vertical" then
					return 100
					-- return vim.o.columns * 0.4
				end
			end,
			shade_terminals = false,
			start_in_insert = false,
			insert_mappings = false, -- whether or not the open mapping applies in insert mode
			persist_size = false,
			direction = "float",
			close_on_exit = false, -- close the terminal window when the process exits
			float_opts = {
				width = 1e6,
				height = 1e6,
			},
		})
	end,
}
