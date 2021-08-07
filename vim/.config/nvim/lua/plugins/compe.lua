local M = {}
M.setup = function()
  --------Completion-----------
  require "compe".setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "always",
    throttle_time = 80,
    source_timeout = 200,
    resolve_timeout = 800,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    -- documentation = true,

    documentation = {
      border = {"", "", "", " ", "", "", "", " "}, -- the border option is the same as `|help nvim_open_win|`
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
      max_width = 120,
      min_width = 60,
      max_height = math.floor(vim.o.lines * 0.5),
      min_height = 1
    },
    source = {
      path = {kind = "   (Path)"},
      buffer = {kind = "   (Buffer)"},
      calc = {kind = "   (Calc)"},
      vsnip = {kind = "   (Snippet)"},
      nvim_lsp = {kind = "   (LSP)"},
      nvim_lua = true,
      ultisnips = false,
      luasnip = false
    }
  }

  map("i", "<CR>", "compe#confirm({ 'keys': '<CR>' })", {expr = true, silent = true})

  -- snippets
  bufmap(0, "i", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)':'<Tab>'", {expr = true})
  bufmap(0, "s", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)':'<Tab>'", {expr = true})
  bufmap(0, "i", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)':'<S-Tab>'", {expr = true})
  bufmap(0, "s", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)':'<S-Tab>'", {expr = true})
end
return M
