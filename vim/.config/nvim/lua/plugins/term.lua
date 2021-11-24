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
	-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
	-- direction = "vertical",
	direction = "horizontal",
	close_on_exit = false, -- close the terminal window when the process exits
	--shell = vim.o.shell, -- change the default shell
})
