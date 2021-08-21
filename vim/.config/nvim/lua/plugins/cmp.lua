local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")

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

cmp.setup {
  -- You should change this example to your chosen snippet engine.
  snippet = {
    expand = function(args)
      -- You must install `vim-vsnip` if you set up as same as the following.
      require "luasnip".lsp_expand(args.body)
    end
  },
  -- You must set mapping.
  mapping = {
    ["<Up>"] = cmp.mapping.prev_item(),
    ["<Down>"] = cmp.mapping.next_item(),
    ["<C-d>"] = cmp.mapping.scroll(-4),
    ["<C-f>"] = cmp.mapping.scroll(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm(
      {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      }
    ),
    ["<Tab>"] = cmp.mapping.mode(
      {"i", "s"},
      function(_, fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end
    ),
    ["<S-Tab>"] = cmp.mapping.mode(
      {"i", "s"},
      function(_, fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
        elseif luasnip.jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end
    )
  },
  -- You should specify your *installed* sources.
  sources = {
    {name = "nvim_lsp"},
    {name = "luasnip"},
    {name = "nvim_lua"},
    {name = "buffer"},
    {name = "path"},
    {name = "calc"},
    {name = "emoji"}
  },
  completion = {
    autocomplete = {
      types.cmp.TriggerEvent.InsertEnter,
      types.cmp.TriggerEvent.TextChanged
    },
    completeopt = "menu,menuone,noinsert",
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 2
  }
}
for index, value in ipairs(lsp.protocol.CompletionItemKind) do
  cmp.lsp.CompletionItemKind[index] = value
end

require("luasnip/loaders/from_vscode").lazy_load()
