local colors = {
	bg = "#282a36",
	bgdark = "#21222C",
	fg = "#F8F8F2",
	yellow = "#F5F7A8",
	cyan = "#ACEBFB",
	darkblue = "#081633",
	green = "#88F298",
	orange = "#F4B26D",
	violet = "#BF9EEE",
	magenta = "#F199CE",
	blue = "#ACEBFB",
	red = "#EE766D",
	bglight = "#6272a4",
}

local feline = require("feline")
local lsp = require("feline.providers.lsp")

local components = {
	active = {},
	inactive = {},
}

local vi_mode_colors = {
	NORMAL = colors.green,
	INSERT = colors.magenta,
	VISUAL = colors.yellow,
	OP = colors.green,
	BLOCK = colors.yellow,
	LINES = colors.yellow,
	REPLACE = colors.red,
	["V-REPLACE"] = colors.red,
	ENTER = colors.cyan,
	MORE = colors.cyan,
	SELECT = colors.orange,
	COMMAND = colors.red,
	SHELL = colors.green,
	TERM = colors.magenta,
	NONE = colors.yellow,
}

table.insert(components.active, {})
table.insert(components.active, {})

table.insert(components.inactive, {})
table.insert(components.inactive, {})

local split = function(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local ins_left = function(component)
	table.insert(components.active[1], component)
end
local ins_right = function(component)
	table.insert(components.active[#components.active], component)
end

local short_ins_left = function(component)
	table.insert(components.inactive[1], component)
end
local short_ins_right = function(component)
	table.insert(components.inactive[#components.active], component)
end

local block = {
	provider = "▊",
	hl = { fg = colors.violet, bg = colors.bgdark },
}
ins_left(block)

local vi_mode = {
	provider = " ",
	hl = function()
		return { fg = require("feline.providers.vi_mode").get_mode_color(), bg = colors.bgdark }
	end,
	left_sep = " ",
	right_sep = " ",
}
ins_left(vi_mode)

local file_path = {
	provider = function(winid)
		local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid)), ":~:.")
		local splitpath = split(filepath, "/")
		splitpath[#splitpath] = ""
		filepath = table.concat(splitpath, "/")
		return filepath
	end,
	hl = function(winid)
		local bufnr = api.nvim_win_get_buf(winid)
		local res = { fg = colors.yellow, bg = colors.bgdark, style = "bold" }
		if vim.bo[bufnr].modifiable and vim.bo[bufnr].modified then
			res.fg = colors.red
		end
		return res
	end,
}
ins_left(file_path)

local file_name = {
	provider = function(winid)
		return fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid)), ":t")
	end,
	hl = function(winid)
		local bufnr = api.nvim_win_get_buf(winid)
		local res = { fg = colors.fg, bg = colors.bgdark, style = "bold" }
		if vim.bo[bufnr].modifiable and vim.bo[bufnr].modified then
			res.fg = colors.red
		end
		return res
	end,
	icon = "",
}
ins_left(file_name)

local file_icon = {
	provider = function()
		local filename = vim.fn.expand("%:t")
		local extension = vim.fn.expand("%:e")
		local icon = require("nvim-web-devicons").get_icon(filename, extension)
		if icon == nil then
			icon = " "
		end
		return icon
	end,
	hl = { fg = colors.cyan, bg = colors.bgdark },
	left_sep = " ",
	right_sep = " ",
}
ins_left(file_icon)

local position = {
	provider = "position",
	hl = { fg = colors.fg, bg = colors.bgdark },
	left_sep = " ",
	right_sep = " ",
}
ins_left(position)

local line_percentage = {
	provider = "line_percentage",
	hl = { fg = colors.fg, style = "bold", bg = colors.bgdark },
	right_sep = " ",
}
ins_left(line_percentage)

local diagnostic_error = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
	end,
	hl = { fg = colors.red, bg = colors.bgdark },
}
ins_left(diagnostic_error)

local diagnostic_warnings = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
	end,
	hl = { fg = colors.orange, bg = colors.bgdark },
}
ins_left(diagnostic_warnings)

local diagnostic_hints = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
	end,
	hl = { fg = colors.blue, bg = colors.bgdark },
}
ins_left(diagnostic_hints)

local diagnostic_info = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
	end,
	hl = { fg = colors.blue, bg = colors.bgdark },
}
ins_left(diagnostic_info)

local lsp_clients = {
	provider = " LSP",
	enabled = function()
		return lsp.is_lsp_attached()
	end,
	hl = { fg = colors.fg, bg = colors.bgdark, style = "bold" },
	right_sep = " ",
}
ins_right(lsp_clients)

local diff_add = {
	provider = "git_diff_added",
	hl = { fg = colors.green, bg = colors.bgdark },
	icon = "  ",
}
ins_right(diff_add)

local diff_change = {
	provider = "git_diff_changed",
	hl = { fg = colors.orange, bg = colors.bgdark },
	icon = "  ",
}
ins_right(diff_change)

local diff_removed = {
	provider = "git_diff_removed",
	hl = { fg = colors.red, bg = colors.bgdark },
	icon = "  ",
}
ins_right(diff_removed)

ins_right({ provider = " " })
local git_branch = {
	provider = "git_branch",
	hl = { fg = colors.green, bg = colors.bgdark, style = "bold" },
	left_sep = " ",
	right_sep = " ",
}
ins_right(git_branch)
ins_right(block)

local short_block = {
	provider = "▊",
	hl = { fg = colors.bglight, bg = colors.bgdark },
}

short_ins_left(short_block)
short_ins_left({ provider = " " })

short_ins_left(file_path)
short_ins_left(file_name)
short_ins_left(file_icon)

short_ins_right(short_block)

local disable = {
	filetypes = {
		"NvimTree",
		"packer",
		"startify",
		"fugitive",
		"fugitiveblame",
		"qf",
		"help",
	},
	buftypes = {
		"terminal",
		"TelescopePrompt",
	},
	bufnames = {},
}

feline.setup({
	colors = {
		bg = colors.bgdark,
		fg = colors.fg,
	},
	components = components,
	vi_mode_colors = vi_mode_colors,
	update_triggers = { "VimEnter", "WinEnter", "WinClosed", "FileChangedShellPost", "BufModifiedSet" },
	disable = disable,
})
