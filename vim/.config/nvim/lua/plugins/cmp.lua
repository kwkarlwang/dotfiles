local cmp = require("cmp")
local mapping = require("cmp.config.mapping")
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

cmp.setup({
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
	end,
	completion = {
		autocomplete = {
			types.cmp.TriggerEvent.TextChanged,
		},
		completeopt = "menu,menuone,noinsert",
		keyword_length = 1,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<Down>"] = mapping({
			i = mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
			c = mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
		}),
		["<Up>"] = mapping({
			i = mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
			c = mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
		}),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-q>"] = cmp.config.disable,
		["<C-e>"] = mapping.abort(),
		["<CR>"] = mapping({
			i = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = false,
			}),
		}),
		["<Tab>"] = mapping({
			c = function(fallback)
				if #cmp.core:get_sources() > 0 and not cmp.get_config().experimental.native_menu then
					cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
					-- end)
					vim.schedule(function()
						cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
					end)
				else
					fallback()
				end
			end,
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
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = icons[vim_item.kind] .. vim_item.kind
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
	preselect = types.cmp.PreselectMode.None,
})
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
-- cmd([[hi CmpItemAbbr guifg=#eceff4]])
-- cmd([[hi CmpItemAbbrMatch guifg=#ACEBFB gui=bold]])
-- cmd([[hi CmpItemKind guifg=#a3c4ef]])
-- cmd([[hi CmpItemKindFunction guifg=#88F298]])
-- cmd([[hi CmpItemKindMethod guifg=#88F298]])
-- cmd([[hi CmpItemKindText guifg=#F5F7A8]])
-- cmd([[hi CmpItemKindField guifg=#Bf9EEE]])
-- cmd([[hi CmpItemKindValue guifg=#Bf9EEE]])
-- cmd([[hi CmpItemKindKeyword guifg=#ACEBFB]])
-- cmd([[hi CmpItemKindVariable guifg=#F199CE]])
-- cmd([[hi CmpItemKindSnippet guifg=#F8F8F2]])
-- cmd([[hi CmpItemMenu guifg=#F4B26D]])
