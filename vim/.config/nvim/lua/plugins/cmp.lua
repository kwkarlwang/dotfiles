local cmp = require("cmp")

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
      vim.fn["vsnip#anonymous"](args.body)
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
    )
  },
  -- You should specify your *installed* sources.
  sources = {
    {name = "nvim_lsp"},
    {name = "vsnip"},
    {name = "nvim_lua"},
    {name = "buffer"},
    {name = "path"},
    {name = "calc"},
    {name = "emoji"}
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 2
  }
}
for index, value in ipairs(lsp.protocol.CompletionItemKind) do
  cmp.lsp.CompletionItemKind[index] = value
end
