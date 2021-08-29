local cmp = require("cmp")
local types = require("cmp.types")

lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)"
}

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end
cmp.setup {
  snippet = {
    expand = function(args)
      -- You must install `vim-vsnip` if you set up as same as the following.
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = {
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm(
      {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true
      }
    ),
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
        elseif check_back_space() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n")
        elseif vim.fn["vsnip#available"]() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
        else
          fallback()
        end
      end,
      {"i", "s", "n"}
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
        elseif vim.fn["vsnip#available"]() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
        else
          fallback()
        end
      end,
      {"i", "s", "n"}
    )
  },
  sources = {
    {name = "nvim_lsp"},
    {name = "buffer"},
    {name = "vsnip"},
    {name = "cmp_tabnine"},
    {name = "nvim_lua"},
    {name = "path"},
    {name = "calc"},
    {name = "emoji"}
  },
  completion = {
    autocomplete = {
      types.cmp.TriggerEvent.TextChanged
    },
    completeopt = "menu,menuone,noinsert",
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu =
        ({
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        calc = "[Calc]",
        emoji = "[Emoji]",
        vsnip = "[VSnip]",
        cmp_tabnine = "[TabNine]"
      })[entry.source.name]
      return vim_item
    end
  }
}
for index, value in ipairs(lsp.protocol.CompletionItemKind) do
  cmp.lsp.CompletionItemKind[index] = value
end
