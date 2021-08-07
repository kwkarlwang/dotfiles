local colors = {
  bg = "#21222C",
  fg = "#F8F8F2",
  yellow = "#F5F7A8",
  cyan = "#ACEBFB",
  darkblue = "#081633",
  green = "#88F298",
  orange = "#F4B26D",
  violet = "#BF9EEE",
  magenta = "#F199CE",
  blue = "#ACEBFB",
  red = "#EE766D"
}

local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {"NvimTree", "toggleterm"}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end
local function ins_left(component)
  table.insert(gls.left, component)
end
local function ins_right(component)
  table.insert(gls.right, component)
end

ins_left(
  {
    RainbowRed = {
      provider = function()
        return "▊ "
      end,
      highlight = {colors.violet, colors.bg}
    }
  }
)
ins_left(
  {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
        local mode_color = {
          n = colors.green,
          i = colors.magenta,
          v = colors.yellow,
          [""] = colors.yellow,
          V = colors.yellow,
          c = colors.red,
          no = colors.magenta,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.red,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red
        }
        vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
        return "  "
      end,
      highlight = {colors.red, colors.bg, "bold"}
    }
  }
)

ins_left(
  {
    FileSize = {
      provider = "FileSize",
      condition = buffer_not_empty,
      separator = " ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {colors.fg, colors.bg}
    }
  }
)
-- gls.left[4] = {
--   FileIcon = {
--     provider = "FileIcon",
--     condition = buffer_not_empty,
--     highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
--   }
-- }

local buffer_modified = function()
  if vim.bo.modifiable then
    if vim.bo.modified then
      return {colors.red, colors.bg, "bold"}
    end
  end
  return {colors.yellow, colors.bg, "bold"}
end
ins_left(
  {
    FileName = {
      provider = {"FileName", "FileIcon"},
      condition = buffer_not_empty,
      separator = " ",
      separator_highlight = {"NONE", colors.bg},
      -- highlight = {colors.yellow, colors.bg, "bold"}
      highlight = buffer_modified,
      event = "BufModifiedSet"
    }
  }
)

ins_left(
  {
    LineInfo = {
      provider = "LineColumn",
      -- separator = " ",
      -- separator_highlight = {"NONE", colors.bg},
      highlight = {colors.fg, colors.bg}
    }
  }
)

ins_left(
  {
    PerCent = {
      provider = "LinePercent",
      separator = " ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {colors.fg, colors.bg, "bold"}
    }
  }
)

ins_left(
  {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = {colors.red, colors.bg}
    }
  }
)
ins_left(
  {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = {colors.yellow, colors.bg}
    }
  }
)

ins_left(
  {
    DiagnosticHint = {
      provider = "DiagnosticHint",
      icon = "  ",
      highlight = {colors.cyan, colors.bg}
    }
  }
)

ins_left(
  {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      icon = "  ",
      highlight = {colors.blue, colors.bg}
    }
  }
)

-- gls.right[1] = {
--   FileEncode = {
--     provider = "FileEncode",
--     separator = " ",
--     separator_highlight = {"NONE", colors.bg},
--     highlight = {colors.cyan, colors.bg, "bold"}
--   }
-- }

-- gls.right[1] = {
--   FileFormat = {
--     provider = "FileFormat",
--     separator = " ",
--     separator_highlight = {"NONE", colors.bg},
--     highlight = {colors.cyan, colors.bg, "bold"}
--   }
-- }

ins_right(
  {
    LspStatus = {
      provider = function()
        local msg = ""
        local buf_ft = api.nvim_buf_get_option(0, "filetype")
        local clients = lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and fn.index(filetypes, buf_ft) ~= -1 then
            return " LSP:" .. client.name
          end
        end
        return msg
      end,
      highlight = {colors.fg, colors.bg, "bold"}
    }
  }
)

ins_right(
  {
    DiffAdd = {
      provider = "DiffAdd",
      -- icon = "  ",
      icon = "  ",
      separator = " ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {colors.green, colors.bg}
    }
  }
)
ins_right(
  {
    DiffModified = {
      provider = "DiffModified",
      -- icon = "  ",
      icon = "  ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {colors.orange, colors.bg}
    }
  }
)
ins_right(
  {
    DiffRemove = {
      provider = "DiffRemove",
      -- icon = "  ",
      icon = "  ",
      separator_highlight = {"NONE", colors.bg},
      highlight = {colors.red, colors.bg}
    }
  }
)

-- ins_right(
--   {
--     GitIcon = {
--       provider = function()
--         return "  "
--       end,
--       condition = require("galaxyline.provider_vcs").check_git_workspace,
--       -- separator = " ",
--       -- separator_highlight = {"NONE", colors.bg},
--       highlight = {colors.green, colors.bg, "bold"}
--     }
--   }
-- )

ins_right(
  {
    GitBranch = {
      provider = "GitBranch",
      icon = "  ",
      condition = require("galaxyline.provider_vcs").check_git_workspace,
      highlight = {colors.green, colors.bg, "bold"}
    }
  }
)

ins_right(
  {
    RainbowBlue = {
      provider = function()
        return " ▊"
      end,
      highlight = {colors.violet, colors.bg},
      separator = " ",
      separator_highlight = {"NONE", colors.bg}
    }
  }
)

gls.short_line_left[1] = {
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = {"NONE", colors.bg},
    highlight = {colors.blue, colors.bg, "bold"}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider = {
      function()
        local fileinfo = require("galaxyline.provider_fileinfo")
        local fname = fileinfo.get_current_file_name()
        for _, v in ipairs(gl.short_line_list) do
          if v == vim.bo.filetype then
            return ""
          end
        end
        return fname
      end,
      "FileIcon"
    },
    condition = buffer_not_empty,
    highlight = buffer_modified
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = {colors.fg, colors.bg}
  }
}
