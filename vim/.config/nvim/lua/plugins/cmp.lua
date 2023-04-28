return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-emoji",
		"lukas-reineke/cmp-under-comparator",
		{
			"petertriho/cmp-git",
			config = function()
				require("cmp_git").setup()
			end,
		},
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"kwkarlwang/cmp-nvim-insert-text-lsp",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		local mapping = require("cmp.config.mapping")
		local sources = require("cmp.config.sources")
		local types = require("cmp.types")

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

		-- local has_words_before = function()
		-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		-- end
		local super_tab = function(fallback)
			-- if cmp.visible() then
			-- 	cmp.select_next_item()
			local luasnip = require("luasnip")
			if luasnip.jumpable() then
				luasnip.jump(1)
				-- elseif has_words_before() then
				-- 	cmp.complete()
			else
				fallback()
			end
		end
		cmp.setup({
			enabled = function()
				return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
			end,
			completion = {
				completeopt = "menu,menuone,noinsert",
				keyword_length = 1,
			},
			snippet = {
				expand = function(args)
					local luasnip = require("luasnip")
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
				["<C-e>"] = cmp.config.disable,
				["<C-c>"] = mapping.abort(),
				["<CR>"] = mapping({
					i = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = false,
					}),
				}),
				["<Tab>"] = mapping({
					i = super_tab,
					s = super_tab,
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

				["<S-Tab>"] = mapping(function(fallback)
					-- if cmp.visible() then
					-- 	cmp.select_prev_item()
					local luasnip = require("luasnip")
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			sources = sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "calc" },
				{ name = "emoji" },
			}),
			formatting = {
				fields = { "abbr", "kind" },
				format = function(_, vim_item)
					vim_item.kind = icons[vim_item.kind] .. vim_item.kind
					return vim_item
				end,
			},
			preselect = types.cmp.PreselectMode.None,
			sorting = {
				comparators = {
					require("cmp-under-comparator").under,
				},
			},
		})
		cmp.setup.filetype({ "markdown" }, {
			sources = sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "spell" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "calc" },
				{ name = "emoji" },
			}),
		})

		cmp.setup.filetype({ "cpp" }, {
			sources = sources({
				{ name = "nvim_insert_text_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "calc" },
				{ name = "emoji" },
			}),
		})
		cmp.setup.filetype({ "java", "go" }, {
			mapping = {
				["<CR>"] = mapping({
					i = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
				}),
			},
		})

		cmp.setup.filetype({ "gitcommit", "NeogitCommitMessage" }, {
			sources = sources({
				{ { name = "cmp_git" } },
				{ { name = "buffer" } },
			}),
		})
		cmp.setup.cmdline("/", {
			sources = sources({
				{ name = "buffer" },
			}, {
				{ name = "nvim_lsp_document_symbol" },
			}),
		})
		cmp.setup.cmdline(":", {
			sources = sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
