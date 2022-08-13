local M = {}
local utils = require("telescope.utils")
M.split = function(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end
M.gen_from_file = function(opts)
	local lookup_keys = {
		ordinal = 1,
		value = 1,
		filename = 1,
		cwd = 2,
	}
	local entry_display = require("telescope.pickers.entry_display")
	local Path = require("plenary.path")
	opts = opts or {}

	local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

	local disable_devicons = opts.disable_devicons

	local mt_file_entry = {}

	mt_file_entry.cwd = cwd
	local displayer = entry_display.create({
		separator = "",
		items = {
			{ width = 0.4 },
			{ remaining = true },
		},
	})
	mt_file_entry.display = function(entry)
		local hl_group
		local display = entry.value

		local splitpath = M.split(display, "/")
		local filename = splitpath[#splitpath]
		splitpath[#splitpath] = ""
		local filepath = table.concat(splitpath, "/")
		filepath = string.gsub(filepath, "/$", "")

		filename, hl_group = utils.transform_devicons(entry.value, filename, disable_devicons)

		display = displayer({ filename, filepath })
		if hl_group then
			return display, { { { 1, 3 }, hl_group }, { { #filename + 1, 1000 }, "Comment" } }
		else
			return display
		end
	end

	mt_file_entry.__index = function(t, k)
		local raw = rawget(mt_file_entry, k)
		if raw then
			return raw
		end

		if k == "path" then
			local retpath = Path:new({ t.cwd, t.value }):absolute()
			if not vim.loop.fs_access(retpath, "R", nil) then
				retpath = t.value
			end
			return retpath
		end
		return rawget(t, rawget(lookup_keys, k))
	end

	return function(line)
		return setmetatable({ line }, mt_file_entry)
	end
end

M.file_exists = function(name)
	local f = io.open(name, "r")
	if f == nil then
		return false
	else
		io.close(f)
		return true
	end
end
return M
