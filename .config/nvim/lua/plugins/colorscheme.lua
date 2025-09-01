return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false, bold = true },
        functions = { bold = true },
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "packer", "neo-tree" },
      on_colors = function(colors)
        -- Pure black background
        colors.bg = "#000000"
        colors.bg_dark = "#080808"
        colors.bg_float = "#121212"
        colors.bg_highlight = "#1a1a1a"
        colors.bg_popup = "#121212"
        colors.bg_sidebar = "#0a0a0a"
        colors.bg_statusline = "#121212"
        colors.bg_visual = "#2a1a1a"

        -- Bright text colors
        colors.fg = "#ffffff"
        colors.fg_dark = "#b0b0b0"
        colors.fg_gutter = "#505050"
        colors.fg_sidebar = "#ffffff"

        -- VIBRANT COLORS
        colors.red = "#ff0000" -- red
        colors.red1 = "#ff3388" -- Bright pink
        colors.red2 = "#ff0044" -- Intense red

        colors.blue = "#00ccff" -- Electric blue
        colors.green = "#00ff99" -- Electric green
        colors.yellow = "#ffffff" -- WHITE instead of yellow
        colors.orange = "#ff9900" -- Bright orange (kept but not used for files)
        colors.purple = "#FFD700" -- Gold
        colors.cyan = "#00ffff" -- Bright electric cyan
        colors.pink = "#ff66ff" -- Bright pink

        colors.white = "#ffffff"
        colors.silver = "#c0c0c0"

        -- UI colors
        colors.border = "#404040"
        colors.border_highlight = "#ff0066"

        -- Diagnostic colors
        colors.error = "#ff0066"
        colors.warning = "#ff9900"
        colors.info = "#00ffff" -- Bright cyan
        colors.hint = "#ff3388"
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
        highlights.CursorLineNr = { fg = colors.red, bold = true }

        -- Search - white and cyan
        highlights.Search = { bg = colors.white, fg = "#000000", bold = true }
        highlights.IncSearch = { bg = colors.cyan, fg = "#000000", bold = true }
        highlights.CurSearch = { bg = colors.red, fg = "#000000", bold = true }

        -- SYNTAX HIGHLIGHTING
        highlights.Comment = { fg = "#888888", italic = true }
        highlights.Keyword = { fg = colors.red, bold = true }
        highlights.Function = { fg = colors.blue, bold = true }
        highlights.String = { fg = colors.green }
        highlights.Number = { fg = colors.cyan } -- Cyan instead of orange
        highlights.Boolean = { fg = colors.cyan } -- Cyan instead of orange
        highlights.Constant = { fg = colors.red }
        highlights.Variable = { fg = colors.fg }
        highlights.Type = { fg = colors.purple }
        highlights.Operator = { fg = colors.red }
        highlights.Special = { fg = colors.pink }
        highlights.Identifier = { fg = colors.fg }
        highlights.PreProc = { fg = colors.red }
        highlights.Include = { fg = colors.red }
        highlights.Define = { fg = colors.purple }
        highlights.Macro = { fg = colors.red }
        highlights.StorageClass = { fg = colors.blue, bold = true }
        highlights.Structure = { fg = colors.purple }
        highlights.Typedef = { fg = colors.purple }

        -- Language specific
        highlights["@keyword.function"] = { fg = colors.red, bold = true }
        highlights["@keyword.return"] = { fg = colors.red, bold = true }
        highlights["@keyword.operator"] = { fg = colors.red }
        highlights["@variable.builtin"] = { fg = colors.cyan }
        highlights["@property"] = { fg = colors.green }
        highlights["@parameter"] = { fg = colors.fg }
        highlights["@constructor"] = { fg = colors.blue, bold = true }
        highlights["@tag"] = { fg = colors.red }
        highlights["@tag.attribute"] = { fg = colors.cyan }
        highlights["@tag.delimiter"] = { fg = colors.red }
        highlights["@type"] = { fg = colors.purple }
        highlights["@type.builtin"] = { fg = colors.red }

        -- HTML
        highlights.htmlTag = { fg = colors.red }
        highlights.htmlEndTag = { fg = colors.red }
        highlights.htmlTagName = { fg = colors.red }
        highlights.htmlArg = { fg = colors.cyan }
        highlights.htmlString = { fg = colors.green }

        -- CSS
        highlights.cssProp = { fg = colors.cyan }
        highlights.cssAttr = { fg = colors.green }
        highlights.cssValueLength = { fg = colors.cyan } -- Cyan instead of orange
        highlights.cssValueNumber = { fg = colors.cyan } -- Cyan instead of orange
        highlights.cssClassName = { fg = colors.green }
        highlights.cssIdentifier = { fg = colors.blue }

        -- Popup menus
        highlights.Pmenu = { fg = colors.fg, bg = colors.bg_float }
        highlights.PmenuSel = { fg = "#000000", bg = colors.red }
        highlights.PmenuSbar = { bg = colors.bg_highlight }
        highlights.PmenuThumb = { bg = colors.cyan }

        -- Statusline
        highlights.StatusLine = { fg = colors.fg, bg = colors.bg_float }
        highlights.StatusLineNC = { fg = colors.fg_dark, bg = colors.bg }

        -- Tabline
        highlights.TabLine = { fg = colors.fg_dark, bg = colors.bg }
        highlights.TabLineFill = { bg = colors.bg }
        highlights.TabLineSel = { fg = colors.red, bg = colors.bg_float, bold = true }

        -- Splits
        highlights.VertSplit = { fg = colors.border }
        highlights.WinSeparator = { fg = colors.border }

        -- Git signs
        highlights.GitSignsAdd = { fg = colors.green }
        highlights.GitSignsChange = { fg = colors.white } -- White instead of yellow
        highlights.GitSignsDelete = { fg = colors.red }

        -- Diagnostics
        highlights.DiagnosticError = { fg = colors.error }
        highlights.DiagnosticWarn = { fg = colors.white } -- White instead of orange
        highlights.DiagnosticInfo = { fg = colors.cyan } -- Bright cyan
        highlights.DiagnosticHint = { fg = colors.hint }

        -- LSP
        highlights.LspReferenceText = { bg = colors.bg_visual }
        highlights.LspReferenceRead = { bg = colors.bg_visual }
        highlights.LspReferenceWrite = { bg = colors.bg_visual }

        -- Telescope
        highlights.TelescopeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.TelescopeBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopePromptBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopeResultsBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopePreviewBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopeSelection = { fg = colors.fg, bg = colors.bg_visual }
        highlights.TelescopeSelectionCaret = { fg = colors.red }
        highlights.TelescopePromptPrefix = { fg = colors.red }
        highlights.TelescopeMatching = { fg = colors.white, bold = true } -- White instead of yellow

        -- Neo-tree - green files instead of orange
        highlights.NeoTreeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeDirectoryName = { fg = colors.cyan }
        highlights.NeoTreeDirectoryIcon = { fg = colors.cyan }
        highlights.NeoTreeFileName = { fg = colors.fg }
        highlights.NeoTreeFileIcon = { fg = colors.green } -- Green instead of blue
        highlights.NeoTreeGitAdded = { fg = colors.green }
        highlights.NeoTreeGitModified = { fg = colors.white } -- White instead of yellow
        highlights.NeoTreeGitDeleted = { fg = colors.red }
        highlights.NeoTreeRootName = { fg = colors.red, bold = true }

        -- Which-key
        highlights.WhichKey = { fg = colors.cyan }
        highlights.WhichKeyGroup = { fg = colors.red }
        highlights.WhichKeyDesc = { fg = colors.fg }
        highlights.WhichKeySeperator = { fg = colors.purple }
        highlights.WhichKeyFloat = { bg = colors.bg }
        highlights.WhichKeyBorder = { fg = colors.cyan, bg = colors.bg }

        -- Completion menu
        highlights.CmpItemAbbr = { fg = colors.fg }
        highlights.CmpItemAbbrDeprecated = { fg = colors.fg_gutter, strikethrough = true }
        highlights.CmpItemAbbrMatch = { fg = colors.cyan, bold = true }
        highlights.CmpItemAbbrMatchFuzzy = { fg = colors.cyan, bold = true }
        highlights.CmpItemKind = { fg = colors.red }
        highlights.CmpItemMenu = { fg = colors.cyan }

        -- Special enhancements
        highlights.Title = { fg = colors.red, bold = true }
        highlights.Underlined = { fg = colors.cyan, underline = true }
        highlights.Debug = { fg = colors.cyan } -- Cyan instead of orange
        highlights.Tag = { fg = colors.purple }

        -- Diff
        highlights.DiffAdd = { fg = colors.green, bg = "#1a2a1a" }
        highlights.DiffChange = { fg = colors.white, bg = "#2a2a1a" } -- White instead of yellow
        highlights.DiffDelete = { fg = colors.red, bg = "#2a1a1a" }
        highlights.DiffText = { fg = colors.cyan, bg = "#2a2a1a" }

        -- Additional
        highlights.Cursor = { fg = colors.bg, bg = colors.red }
        highlights.MatchParen = { fg = colors.red, bold = true, underline = true }
      end,
    },
  },
}
