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
        -- True black background with red accents
        colors.bg = "#000000" -- Pure black
        colors.bg_dark = "#080808"
        colors.bg_float = "#121212"
        colors.bg_highlight = "#1a1a1a"
        colors.bg_popup = "#121212"
        colors.bg_sidebar = "#0a0a0a"
        colors.bg_statusline = "#121212"
        colors.bg_visual = "#2a1a1a" -- Red tinted visual selection

        -- Text colors - high contrast with red emphasis
        colors.fg = "#ffffff"
        colors.fg_dark = "#cccccc"
        colors.fg_gutter = "#666666"
        colors.fg_sidebar = "#ffffff"

        -- Red-dominated color palette
        colors.red = "#ff4757" -- Vibrant primary red
        colors.red1 = "#ff6b6b" -- Bright red
        colors.red2 = "#ff3838" -- Intense red
        colors.crimson = "#ff5252"
        colors.coral = "#ff7f50"

        colors.cyan = "#00e0e0"
        colors.teal = "#20c0c0"
        colors.orange = "#ffa500"
        colors.pink = "#ff4757" -- Red instead of pink
        colors.white = "#ffffff"
        colors.silver = "#c0c0c0"

        colors.blue = "#7aa2f7" -- Tokyo Night blue
        colors.green = "#9ece6a" -- Tokyo Night green
        colors.yellow = "#e0af68" -- Tokyo Night yellow (muted gold)
        colors.purple = "#bb9af7" -- Tokyo Night purple

        -- UI colors with red accents
        colors.border = "#404040"
        colors.border_highlight = "#ff4757"

        -- Diagnostic colors - all red variants
        colors.error = "#ff4757"
        colors.warning = "#e0af68" -- Tokyo Night yellow
        colors.info = "#00e0e0"
        colors.hint = "#ff6b6b"
      end,
      on_highlights = function(highlights, colors)
        -- Base with black background
        highlights.Normal = { fg = colors.fg, bg = colors.bg }
        highlights.NormalFloat = { fg = colors.fg, bg = colors.bg_float }
        highlights.NormalNC = { fg = colors.fg_dark, bg = colors.bg }
        highlights.SignColumn = { bg = colors.bg }
        highlights.EndOfBuffer = { fg = colors.bg_highlight }

        -- Cursor and selection - red accents
        highlights.CursorLine = { bg = colors.bg_highlight }
        highlights.CursorColumn = { bg = colors.bg_highlight }
        highlights.Visual = { bg = colors.bg_visual }
        highlights.VisualNOS = { bg = colors.bg_visual }

        -- Line numbers - red current line
        highlights.LineNr = { fg = colors.fg_gutter }
        highlights.CursorLineNr = { fg = colors.red, bold = true }

        -- Search - red-based search highlights
        highlights.Search = { bg = colors.red, fg = "#000000", bold = true }
        highlights.IncSearch = { bg = colors.cyan, fg = "#000000", bold = true }
        highlights.CurSearch = { bg = colors.red2, fg = "#000000", bold = true }

        -- Syntax highlighting - more red elements
        highlights.Comment = { fg = "#565f89", italic = true } -- Tokyo Night comment color
        highlights.Keyword = { fg = colors.red, bold = true }
        highlights.Function = { fg = colors.cyan, bold = true }
        highlights.String = { fg = colors.green } -- Green strings like Tokyo Night
        highlights.Number = { fg = colors.orange }
        highlights.Boolean = { fg = colors.orange }
        highlights.Constant = { fg = colors.red }
        highlights.Variable = { fg = colors.fg }
        highlights.Type = { fg = colors.blue }
        highlights.Operator = { fg = colors.red }
        highlights.Special = { fg = colors.purple }
        highlights.Identifier = { fg = colors.fg }
        highlights.PreProc = { fg = colors.red }
        highlights.Include = { fg = colors.red }
        highlights.Define = { fg = colors.purple }
        highlights.Macro = { fg = colors.red }
        highlights.StorageClass = { fg = colors.blue, bold = true }
        highlights.Structure = { fg = colors.blue }
        highlights.Typedef = { fg = colors.blue }

        -- Language specific - more red
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
        highlights["@type"] = { fg = colors.blue }
        highlights["@type.builtin"] = { fg = colors.red }

        -- HTML - red tags
        highlights.htmlTag = { fg = colors.red }
        highlights.htmlEndTag = { fg = colors.red }
        highlights.htmlTagName = { fg = colors.red }
        highlights.htmlArg = { fg = colors.cyan }
        highlights.htmlString = { fg = colors.green }

        -- CSS
        highlights.cssProp = { fg = colors.cyan }
        highlights.cssAttr = { fg = colors.green }
        highlights.cssValueLength = { fg = colors.orange }
        highlights.cssValueNumber = { fg = colors.orange }
        highlights.cssClassName = { fg = colors.green }
        highlights.cssIdentifier = { fg = colors.blue }

        -- Popup menus - red selection
        highlights.Pmenu = { fg = colors.fg, bg = colors.bg_float }
        highlights.PmenuSel = { fg = "#000000", bg = colors.red }
        highlights.PmenuSbar = { bg = colors.bg_highlight }
        highlights.PmenuThumb = { bg = colors.red }

        -- Statusline - red accents
        highlights.StatusLine = { fg = colors.fg, bg = colors.bg_float }
        highlights.StatusLineNC = { fg = colors.fg_dark, bg = colors.bg }

        -- Tabline - red active tab
        highlights.TabLine = { fg = colors.fg_dark, bg = colors.bg }
        highlights.TabLineFill = { bg = colors.bg }
        highlights.TabLineSel = { fg = colors.red, bg = colors.bg_float, bold = true }

        -- Splits
        highlights.VertSplit = { fg = colors.border }
        highlights.WinSeparator = { fg = colors.border }

        -- Git signs - red for delete
        highlights.GitSignsAdd = { fg = colors.green }
        highlights.GitSignsChange = { fg = colors.yellow }
        highlights.GitSignsDelete = { fg = colors.red }

        -- Diagnostics - red error and hint
        highlights.DiagnosticError = { fg = colors.error }
        highlights.DiagnosticWarn = { fg = colors.warning }
        highlights.DiagnosticInfo = { fg = colors.info }
        highlights.DiagnosticHint = { fg = colors.hint }

        -- LSP - red references
        highlights.LspReferenceText = { bg = colors.bg_visual }
        highlights.LspReferenceRead = { bg = colors.bg_visual }
        highlights.LspReferenceWrite = { bg = colors.bg_visual }

        -- Telescope - red borders and selection
        highlights.TelescopeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.TelescopeBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopePromptBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopeResultsBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopePreviewBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopeSelection = { fg = colors.fg, bg = colors.bg_visual }
        highlights.TelescopeSelectionCaret = { fg = colors.red }
        highlights.TelescopePromptPrefix = { fg = colors.red }
        highlights.TelescopeMatching = { fg = colors.cyan, bold = true }

        -- Neo-tree - red root and icons
        highlights.NeoTreeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeDirectoryName = { fg = colors.cyan }
        highlights.NeoTreeDirectoryIcon = { fg = colors.red }
        highlights.NeoTreeFileName = { fg = colors.fg }
        highlights.NeoTreeFileIcon = { fg = colors.cyan }
        highlights.NeoTreeGitAdded = { fg = colors.green }
        highlights.NeoTreeGitModified = { fg = colors.yellow }
        highlights.NeoTreeGitDeleted = { fg = colors.red }
        highlights.NeoTreeRootName = { fg = colors.red, bold = true }

        -- Which-key - red groups
        highlights.WhichKey = { fg = colors.cyan }
        highlights.WhichKeyGroup = { fg = colors.red }
        highlights.WhichKeyDesc = { fg = colors.fg }
        highlights.WhichKeySeperator = { fg = colors.red }
        highlights.WhichKeyFloat = { bg = colors.bg }
        highlights.WhichKeyBorder = { fg = colors.red, bg = colors.bg }

        -- Completion menu - red kind
        highlights.CmpItemAbbr = { fg = colors.fg }
        highlights.CmpItemAbbrDeprecated = { fg = colors.fg_gutter, strikethrough = true }
        highlights.CmpItemAbbrMatch = { fg = colors.red, bold = true }
        highlights.CmpItemAbbrMatchFuzzy = { fg = colors.red, bold = true }
        highlights.CmpItemKind = { fg = colors.red }
        highlights.CmpItemMenu = { fg = colors.cyan }

        -- Special enhancements - red titles
        highlights.Title = { fg = colors.red, bold = true }
        highlights.Underlined = { fg = colors.cyan, underline = true }
        highlights.Debug = { fg = colors.orange }
        highlights.Tag = { fg = colors.purple }

        -- Better contrast for special cases - red diff
        highlights.DiffAdd = { fg = colors.green, bg = "#1a2a1a" }
        highlights.DiffChange = { fg = colors.yellow, bg = "#2a2a1a" }
        highlights.DiffDelete = { fg = colors.red, bg = "#2a1a1a" }
        highlights.DiffText = { fg = colors.cyan, bg = "#2a2a1a" }

        -- Additional red enhancements
        highlights.Cursor = { fg = colors.bg, bg = colors.red }
        highlights.MatchParen = { fg = colors.red, bold = true, underline = true }
        highlights.NonText = { fg = colors.fg_gutter }
        highlights.SpecialKey = { fg = colors.red }
        highlights.Whitespace = { fg = colors.fg_gutter }
      end,
    },
  },
}
