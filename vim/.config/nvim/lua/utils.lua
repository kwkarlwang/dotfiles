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
M.quickfix = function()
	local fn = vim.fn

	function _G.qftf(info)
		local items
		local ret = {}
		if info.quickfix == 1 then
			items = fn.getqflist({ id = info.id, items = 0 }).items
		else
			items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
		end
		local limit = 45
		local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
		local validFmt = "%s │%5d:%-3d│%s %s"
		for i = info.start_idx, info.end_idx do
			local e = items[i]
			local fname = ""
			local str
			if e.valid == 1 then
				if e.bufnr > 0 then
					fname = fn.bufname(e.bufnr)
					if fname == "" then
						fname = "[No Name]"
					else
						fname = fname:gsub("^" .. vim.env.HOME, "~")
					end
					-- char in fname may occur more than 1 width, ignore this issue in order to keep performance
					if #fname <= limit then
						fname = fnameFmt1:format(fname)
					else
						fname = fnameFmt2:format(fname:sub(1 - limit))
					end
				end
				local lnum = e.lnum > 99999 and -1 or e.lnum
				local col = e.col > 999 and -1 or e.col
				local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
				str = validFmt:format(fname, lnum, col, qtype, e.text)
			else
				str = e.text
			end
			table.insert(ret, str)
		end
		return ret
	end

	vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
end
return M
