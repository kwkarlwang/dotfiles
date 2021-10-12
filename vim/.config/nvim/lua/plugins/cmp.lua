local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")

local icons = {
	Class = " ",
	Color = " ",
	Constant = "ﲀ ",
	Constructor = " ",
	Enum = "練",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = "",
	Folder = " ",
	Function = " ",
	Interface = "ﰮ ",
	Keyword = " ",
	Method = " ",
	Module = " ",
	Operator = "",
	Property = " ",
	Reference = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = " ",
	Unit = "塞",
	Value = " ",
	Variable = " ",
}
local check_back_space = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-c>"] = function(fallback)
			require("cmp").close()
			fallback()
		end,
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			elseif cmp.visible() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
			elseif check_back_space() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
			else
				fallback()
			end
		end, {
			"i",
			"s",
			"n",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
			"n",
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "calc" },
		{ name = "emoji" },
	},
	completion = {
		autocomplete = {
			types.cmp.TriggerEvent.TextChanged,
		},
		completeopt = "menu,menuone,noinsert",
		keyword_length = 2,
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = icons[vim_item.kind] .. "(" .. vim_item.kind .. ")"
			-- vim_item.menu = ({
			-- 	buffer = "[Buffer]",
			-- 	path = "[Path]",
			-- 	nvim_lsp = "[LSP]",
			-- 	nvim_lua = "[Lua]",
			-- 	calc = "[Calc]",
			-- 	emoji = "[Emoji]",
			-- 	luasnip = "[LuaSnip]",
			-- 	cmp_tabnine = "[TabNine]",
			-- })[entry.source.name]
			return vim_item
		end,
	},
})
cmd([[hi CmpItemKind guifg=#a3c4ef]])
cmd([[hi CmpItemMenu guifg=#F4B26d]])
