return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "packer", "neo-tree" },
      on_colors = function(colors)
        -- One Dark Dark background colors
        colors.bg = "#282C34"
        colors.bg_dark = "#21252B"
        colors.bg_float = "#2C313A"
        colors.bg_highlight = "#2C313A"
        colors.bg_popup = "#2C313A"
        colors.bg_sidebar = "#10151A"
        colors.bg_statusline = "#2C313A"
        colors.bg_visual = "#3E4452"

        -- One Dark text colors
        colors.fg = "#D8DEE9"
        colors.fg_dark = "#9198A2"
        colors.fg_gutter = "#4B5263"
        colors.fg_sidebar = "#D8DEE9"

        -- One Dark color palette - BRIGHTER and more VIBRANT
        colors.red = "#FF6B7F" -- Variables, attributes (brighter red)
        colors.red1 = "#FF4757" -- Error red (more vibrant)
        colors.red2 = "#FF9F7A" -- Orange (brighter)

        colors.blue = "#4FC1FF" -- Functions (brighter blue)
        colors.green = "#8CFF8C" -- Strings (brighter green)
        colors.yellow = "#FFD700" -- Classes (golden yellow)
        colors.orange = "#FFB86C" -- Numbers, booleans (brighter orange)
        colors.purple = "#D66EFD" -- Keywords (brighter purple)
        colors.cyan = "#50E3E3" -- Built-ins, constants (brighter cyan)
        colors.pink = "#FF7CE5" -- Bright pink

        colors.white = "#FFFFFF"
        colors.silver = "#C0C0C0"

        -- UI colors
        colors.border = "#3E4452"
        colors.border_highlight = "#4FC1FF"

        -- Diagnostic colors
        colors.error = "#FF4757"
        colors.warning = "#FFD700"
        colors.info = "#4FC1FF"
        colors.hint = "#50E3E3"
      end,
      on_highlights = function(highlights, colors)
        -- Base
        highlights.Normal = { fg = colors.fg, bg = colors.bg }
        highlights.NormalFloat = { fg = colors.fg, bg = colors.bg_float }
        highlights.NormalNC = { fg = colors.fg_dark, bg = colors.bg }
        highlights.SignColumn = { bg = colors.bg }
        highlights.EndOfBuffer = { fg = colors.bg_highlight }

        -- Cursor and selection
        highlights.CursorLine = { bg = colors.bg_highlight }
        highlights.CursorColumn = { bg = colors.bg_highlight }
        highlights.Visual = { bg = colors.bg_visual }
        highlights.VisualNOS = { bg = colors.bg_visual }

        -- Line numbers
        highlights.LineNr = { fg = colors.fg_gutter }
        highlights.CursorLineNr = { fg = colors.yellow, bold = true }

        -- Search - more vibrant
        highlights.Search = { bg = colors.yellow, fg = "#000000", bold = true }
        highlights.IncSearch = { bg = colors.cyan, fg = "#000000", bold = true }
        highlights.CurSearch = { bg = colors.red, fg = "#000000", bold = true }

        -- SYNTAX HIGHLIGHTING - More vibrant One Dark style
        highlights.Comment = { fg = "#6B7280", italic = true }
        highlights.Keyword = { fg = colors.purple, bold = true }
        highlights.Function = { fg = colors.blue, bold = true }
        highlights.String = { fg = colors.green }
        highlights.Number = { fg = colors.orange }
        highlights.Boolean = { fg = colors.orange }
        highlights.Constant = { fg = colors.cyan }
        highlights.Variable = { fg = colors.red }
        highlights.Type = { fg = colors.yellow, bold = true }
        highlights.Operator = { fg = colors.purple }
        highlights.Special = { fg = colors.pink }
        highlights.Identifier = { fg = colors.red }
        highlights.PreProc = { fg = colors.purple, bold = true }
        highlights.Include = { fg = colors.purple, bold = true }
        highlights.Define = { fg = colors.purple }
        highlights.Macro = { fg = colors.purple }
        highlights.StorageClass = { fg = colors.purple, bold = true }
        highlights.Structure = { fg = colors.yellow, bold = true }
        highlights.Typedef = { fg = colors.yellow, bold = true }

        -- Language specific - more vibrant
        highlights["@keyword"] = { fg = colors.purple, bold = true }
        highlights["@keyword.function"] = { fg = colors.purple, bold = true }
        highlights["@keyword.return"] = { fg = colors.purple, bold = true }
        highlights["@keyword.operator"] = { fg = colors.purple }
        highlights["@variable"] = { fg = colors.red }
        highlights["@variable.builtin"] = { fg = colors.cyan, bold = true }
        highlights["@property"] = { fg = colors.red }
        highlights["@parameter"] = { fg = colors.red }
        highlights["@constructor"] = { fg = colors.yellow, bold = true }
        highlights["@function"] = { fg = colors.blue, bold = true }
        highlights["@function.builtin"] = { fg = colors.blue, bold = true }
        highlights["@function.call"] = { fg = colors.blue, bold = true }
        highlights["@method"] = { fg = colors.blue, bold = true }
        highlights["@method.call"] = { fg = colors.blue, bold = true }
        highlights["@tag"] = { fg = colors.red, bold = true }
        highlights["@tag.attribute"] = { fg = colors.cyan }
        highlights["@tag.delimiter"] = { fg = colors.purple }
        highlights["@type"] = { fg = colors.yellow, bold = true }
        highlights["@type.builtin"] = { fg = colors.yellow, bold = true }
        highlights["@string"] = { fg = colors.green }
        highlights["@number"] = { fg = colors.orange }
        highlights["@boolean"] = { fg = colors.orange }
        highlights["@constant"] = { fg = colors.cyan, bold = true }
        highlights["@constant.builtin"] = { fg = colors.cyan, bold = true }
        highlights["@annotation"] = { fg = colors.cyan }

        -- HTML
        highlights.htmlTag = { fg = colors.red, bold = true }
        highlights.htmlEndTag = { fg = colors.red, bold = true }
        highlights.htmlTagName = { fg = colors.red, bold = true }
        highlights.htmlArg = { fg = colors.cyan }
        highlights.htmlString = { fg = colors.green }

        -- CSS
        highlights.cssProp = { fg = colors.red }
        highlights.cssAttr = { fg = colors.cyan }
        highlights.cssValueLength = { fg = colors.orange }
        highlights.cssValueNumber = { fg = colors.orange }
        highlights.cssClassName = { fg = colors.green }
        highlights.cssIdentifier = { fg = colors.blue }

        -- Popup menus
        highlights.Pmenu = { fg = colors.fg, bg = colors.bg_float }
        highlights.PmenuSel = { fg = "#000000", bg = colors.blue, bold = true }
        highlights.PmenuSbar = { bg = colors.bg_highlight }
        highlights.PmenuThumb = { bg = colors.cyan }

        -- Statusline
        highlights.StatusLine = { fg = colors.fg, bg = colors.bg_float }
        highlights.StatusLineNC = { fg = colors.fg_dark, bg = colors.bg }

        -- Tabline
        highlights.TabLine = { fg = colors.fg_dark, bg = colors.bg }
        highlights.TabLineFill = { bg = colors.bg }
        highlights.TabLineSel = { fg = colors.blue, bg = colors.bg_float, bold = true }

        -- Splits
        highlights.VertSplit = { fg = colors.border }
        highlights.WinSeparator = { fg = colors.border }

        -- Git signs
        highlights.GitSignsAdd = { fg = colors.green, bold = true }
        highlights.GitSignsChange = { fg = colors.yellow, bold = true }
        highlights.GitSignsDelete = { fg = colors.red, bold = true }

        -- Diagnostics
        highlights.DiagnosticError = { fg = colors.error, bold = true }
        highlights.DiagnosticWarn = { fg = colors.warning, bold = true }
        highlights.DiagnosticInfo = { fg = colors.info, bold = true }
        highlights.DiagnosticHint = { fg = colors.hint, bold = true }

        -- LSP
        highlights.LspReferenceText = { bg = colors.bg_visual }
        highlights.LspReferenceRead = { bg = colors.bg_visual }
        highlights.LspReferenceWrite = { bg = colors.bg_visual }

        -- Telescope
        highlights.TelescopeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.TelescopeBorder = { fg = colors.blue, bg = colors.bg }
        highlights.TelescopePromptBorder = { fg = colors.blue, bg = colors.bg }
        highlights.TelescopeResultsBorder = { fg = colors.blue, bg = colors.bg }
        highlights.TelescopePreviewBorder = { fg = colors.blue, bg = colors.bg }
        highlights.TelescopeSelection = { fg = colors.fg, bg = colors.bg_visual }
        highlights.TelescopeSelectionCaret = { fg = colors.blue, bold = true }
        highlights.TelescopePromptPrefix = { fg = colors.blue, bold = true }
        highlights.TelescopeMatching = { fg = colors.yellow, bold = true }

        -- Neo-tree - more vibrant
        highlights.NeoTreeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeDirectoryName = { fg = colors.blue, bold = true }
        highlights.NeoTreeDirectoryIcon = { fg = colors.blue, bold = true }
        highlights.NeoTreeFileName = { fg = colors.fg }
        highlights.NeoTreeFileIcon = { fg = colors.green, bold = true }
        highlights.NeoTreeGitAdded = { fg = colors.green, bold = true }
        highlights.NeoTreeGitModified = { fg = colors.yellow, bold = true }
        highlights.NeoTreeGitDeleted = { fg = colors.red, bold = true }
        highlights.NeoTreeRootName = { fg = colors.blue, bold = true }

        -- Which-key
        highlights.WhichKey = { fg = colors.cyan, bold = true }
        highlights.WhichKeyGroup = { fg = colors.blue, bold = true }
        highlights.WhichKeyDesc = { fg = colors.fg }
        highlights.WhichKeySeperator = { fg = colors.purple }
        highlights.WhichKeyFloat = { bg = colors.bg }
        highlights.WhichKeyBorder = { fg = colors.cyan, bg = colors.bg }

        -- Completion menu
        highlights.CmpItemAbbr = { fg = colors.fg }
        highlights.CmpItemAbbrDeprecated = { fg = colors.fg_gutter, strikethrough = true }
        highlights.CmpItemAbbrMatch = { fg = colors.blue, bold = true }
        highlights.CmpItemAbbrMatchFuzzy = { fg = colors.blue, bold = true }
        highlights.CmpItemKind = { fg = colors.purple, bold = true }
        highlights.CmpItemMenu = { fg = colors.cyan }

        -- Special enhancements
        highlights.Title = { fg = colors.blue, bold = true }
        highlights.Underlined = { fg = colors.cyan, underline = true, bold = true }
        highlights.Debug = { fg = colors.orange, bold = true }
        highlights.Tag = { fg = colors.purple, bold = true }

        -- Diff
        highlights.DiffAdd = { fg = colors.green, bg = "#2D3A2D", bold = true }
        highlights.DiffChange = { fg = colors.yellow, bg = "#3A3A2D", bold = true }
        highlights.DiffDelete = { fg = colors.red, bg = "#3A2D2D", bold = true }
        highlights.DiffText = { fg = colors.cyan, bg = "#2D3A3A", bold = true }

        -- Additional
        highlights.Cursor = { fg = colors.bg, bg = colors.blue }
        highlights.MatchParen = { fg = colors.blue, bold = true, underline = true }
      end,
    },
  },
}
