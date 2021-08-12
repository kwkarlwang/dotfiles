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

local lsp_active = function()
  local clients = lsp.get_active_clients()
  if next(clients) == nil then
    return false
  end
  return true
end

local buffer_modified_path = function()
  if vim.bo.modifiable and vim.bo.modified then
    return {colors.red, colors.bg, "bold"}
  end
  return {colors.yellow, colors.bg, "bold"}
end

local buffer_modified_file = function()
  if vim.bo.modifiable and vim.bo.modified then
    return {colors.red, colors.bg, "bold"}
  end
  return {colors.fg, colors.bg, "bold"}
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 100
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
      condition = buffer_not_empty and hide_in_width,
      -- separator = " ",
      -- separator_highlight = {"NONE", colors.bg},
      highlight = {colors.fg, colors.bg}
    }
  }
)
ins_left(
  {
    FilePath = {
      provider = "FilePath",
      condition = buffer_not_empty,
      highlight = buffer_modified_path
    }
  }
)

ins_left(
  {
    FileName = {
      provider = "FileName",
      condition = buffer_not_empty,
      highlight = buffer_modified_file
    }
  }
)

ins_left {
  FileIcon = {
    provider = "FileIcon",
    condition = buffer_not_empty and hide_in_width,
    separator = " ",
    separator_highlight = {"NONE", colors.bg},
    -- highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
    highlight = {colors.cyan, colors.bg}
  }
}

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
      condition = buffer_not_empty and hide_in_width,
      highlight = {colors.fg, colors.bg, "bold"}
    }
  }
)

ins_left(
  {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = {colors.red, colors.bg},
      condition = hide_in_width
    }
  }
)
ins_left(
  {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = {colors.yellow, colors.bg}
      -- condition = hide_in_width
    }
  }
)

ins_left(
  {
    DiagnosticHint = {
      provider = "DiagnosticHint",
      icon = "  ",
      highlight = {colors.cyan, colors.bg},
      condition = hide_in_width
    }
  }
)

ins_left(
  {
    DiagnosticInfo = {
      provider = "DiagnosticInfo",
      icon = "  ",
      highlight = {colors.blue, colors.bg},
      condition = hide_in_width
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
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and fn.index(filetypes, buf_ft) ~= -1 then
            return " LSP:" .. client.name
          end
        end
        return msg
      end,
      condition = lsp_active and hide_in_width,
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
      highlight = {colors.green, colors.bg},
      condition = hide_in_width
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
      highlight = {colors.orange, colors.bg},
      condition = hide_in_width
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
      highlight = {colors.red, colors.bg},
      condition = hide_in_width
    }
  }
)
ins_right(
  {
    GitBranch = {
      provider = "GitBranch",
      icon = "  ",
      -- condition = require("galaxyline.provider_vcs").check_git_workspace and hide_in_width,
      condition = hide_in_width,
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
  SFilePath = {
    provider = {
      function()
        local fileinfo = require("galaxyline.provider_fileinfo")
        for _, v in ipairs(gl.short_line_list) do
          if v == vim.bo.filetype then
            return ""
          end
        end
        return fileinfo.get_current_file_path()
      end
    },
    condition = buffer_not_empty,
    highlight = buffer_modified_path
  }
}

gls.short_line_left[3] = {
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
      end
    },
    condition = buffer_not_empty,
    highlight = buffer_modified_file,
    event = "BufRead"
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = {colors.fg, colors.bg}
  }
}
