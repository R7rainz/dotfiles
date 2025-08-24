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
        -- Clean dark background
        colors.bg = "#0a0a12"
        colors.bg_dark = "#070710"
        colors.bg_float = "#12121a"
        colors.bg_highlight = "#1a1a25"
        colors.bg_popup = "#12121a"
        colors.bg_sidebar = "#0a0a12"
        colors.bg_statusline = "#12121a"
        colors.bg_visual = "#2a2a45"

        -- Text colors - better contrast
        colors.fg = "#e0e0ff"
        colors.fg_dark = "#b0b0d0"
        colors.fg_gutter = "#505070"
        colors.fg_sidebar = "#e0e0ff"

        -- Modern color palette
        colors.red = "#ff6b6b" -- Bright red
        colors.red1 = "#ff8f8f"
        colors.red2 = "#ff4b4b"
        colors.crimson = "#ff5252"
        colors.coral = "#ff7f7f"

        colors.cyan = "#00e0e0" -- Electric cyan
        colors.teal = "#20c0c0"
        colors.orange = "#ffa500" -- Pure orange
        colors.pink = "#ff80ff" -- Electric pink
        colors.white = "#ffffff"
        colors.silver = "#c0c0e0"

        colors.blue = "#8080ff" -- Electric blue
        colors.green = "#00ff80" -- Electric green
        colors.yellow = "#ffff80" -- Bright yellow
        colors.purple = "#c080ff" -- Electric purple

        -- UI colors
        colors.border = "#404060"
        colors.border_highlight = "#ff80ff"

        -- Diagnostic colors
        colors.error = "#ff6b6b"
        colors.warning = "#ffa500"
        colors.info = "#00e0e0"
        colors.hint = "#ff80ff"
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
        highlights.CursorLineNr = { fg = colors.pink, bold = true }

        -- Search
        highlights.Search = { bg = colors.yellow, fg = "#000000", bold = true }
        highlights.IncSearch = { bg = colors.orange, fg = "#000000", bold = true }
        highlights.CurSearch = { bg = colors.red, fg = "#000000", bold = true }

        -- Syntax highlighting - cleaner and more distinct
        highlights.Comment = { fg = "#708090", italic = true } -- Slate gray
        highlights.Keyword = { fg = colors.pink, bold = true }
        highlights.Function = { fg = colors.cyan, bold = true }
        highlights.String = { fg = colors.yellow }
        highlights.Number = { fg = colors.orange }
        highlights.Boolean = { fg = colors.orange }
        highlights.Constant = { fg = colors.red }
        highlights.Variable = { fg = colors.fg }
        highlights.Type = { fg = colors.blue }
        highlights.Operator = { fg = colors.pink }
        highlights.Special = { fg = colors.purple }
        highlights.Identifier = { fg = colors.fg }
        highlights.PreProc = { fg = colors.purple }
        highlights.Include = { fg = colors.pink }
        highlights.Define = { fg = colors.purple }
        highlights.Macro = { fg = colors.purple }
        highlights.StorageClass = { fg = colors.blue, bold = true }
        highlights.Structure = { fg = colors.blue }
        highlights.Typedef = { fg = colors.blue }

        -- Language specific
        highlights["@keyword.function"] = { fg = colors.pink, bold = true }
        highlights["@keyword.return"] = { fg = colors.pink, bold = true }
        highlights["@keyword.operator"] = { fg = colors.pink }
        highlights["@variable.builtin"] = { fg = colors.cyan }
        highlights["@property"] = { fg = colors.green }
        highlights["@parameter"] = { fg = colors.fg }
        highlights["@constructor"] = { fg = colors.blue, bold = true }
        highlights["@tag"] = { fg = colors.pink }
        highlights["@tag.attribute"] = { fg = colors.orange }
        highlights["@tag.delimiter"] = { fg = colors.pink }

        -- HTML
        highlights.htmlTag = { fg = colors.pink }
        highlights.htmlEndTag = { fg = colors.pink }
        highlights.htmlTagName = { fg = colors.pink }
        highlights.htmlArg = { fg = colors.orange }
        highlights.htmlString = { fg = colors.yellow }

        -- CSS
        highlights.cssProp = { fg = colors.cyan }
        highlights.cssAttr = { fg = colors.orange }
        highlights.cssValueLength = { fg = colors.orange }
        highlights.cssValueNumber = { fg = colors.orange }
        highlights.cssClassName = { fg = colors.green }
        highlights.cssIdentifier = { fg = colors.blue }

        -- Popup menus
        highlights.Pmenu = { fg = colors.fg, bg = colors.bg_float }
        highlights.PmenuSel = { fg = "#000000", bg = colors.cyan }
        highlights.PmenuSbar = { bg = colors.bg_highlight }
        highlights.PmenuThumb = { bg = colors.cyan }

        -- Statusline
        highlights.StatusLine = { fg = colors.fg, bg = colors.bg_float }
        highlights.StatusLineNC = { fg = colors.fg_dark, bg = colors.bg }

        -- Tabline
        highlights.TabLine = { fg = colors.fg_dark, bg = colors.bg }
        highlights.TabLineFill = { bg = colors.bg }
        highlights.TabLineSel = { fg = colors.cyan, bg = colors.bg_float, bold = true }

        -- Splits
        highlights.VertSplit = { fg = colors.border }
        highlights.WinSeparator = { fg = colors.border }

        -- Git signs
        highlights.GitSignsAdd = { fg = colors.green }
        highlights.GitSignsChange = { fg = colors.yellow }
        highlights.GitSignsDelete = { fg = colors.red }

        -- Diagnostics
        highlights.DiagnosticError = { fg = colors.error }
        highlights.DiagnosticWarn = { fg = colors.warning }
        highlights.DiagnosticInfo = { fg = colors.info }
        highlights.DiagnosticHint = { fg = colors.hint }

        -- LSP
        highlights.LspReferenceText = { bg = colors.bg_visual }
        highlights.LspReferenceRead = { bg = colors.bg_visual }
        highlights.LspReferenceWrite = { bg = colors.bg_visual }

        -- Telescope
        highlights.TelescopeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.TelescopeBorder = { fg = colors.cyan, bg = colors.bg }
        highlights.TelescopePromptBorder = { fg = colors.cyan, bg = colors.bg }
        highlights.TelescopeResultsBorder = { fg = colors.cyan, bg = colors.bg }
        highlights.TelescopePreviewBorder = { fg = colors.cyan, bg = colors.bg }
        highlights.TelescopeSelection = { fg = colors.fg, bg = colors.bg_visual }
        highlights.TelescopeSelectionCaret = { fg = colors.cyan }
        highlights.TelescopePromptPrefix = { fg = colors.cyan }
        highlights.TelescopeMatching = { fg = colors.yellow, bold = true }

        -- Neo-tree
        highlights.NeoTreeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeDirectoryName = { fg = colors.cyan }
        highlights.NeoTreeDirectoryIcon = { fg = colors.cyan }
        highlights.NeoTreeFileName = { fg = colors.fg }
        highlights.NeoTreeFileIcon = { fg = colors.orange }
        highlights.NeoTreeGitAdded = { fg = colors.green }
        highlights.NeoTreeGitModified = { fg = colors.yellow }
        highlights.NeoTreeGitDeleted = { fg = colors.red }
        highlights.NeoTreeRootName = { fg = colors.pink, bold = true }

        -- Which-key
        highlights.WhichKey = { fg = colors.cyan }
        highlights.WhichKeyGroup = { fg = colors.pink }
        highlights.WhichKeyDesc = { fg = colors.fg }
        highlights.WhichKeySeperator = { fg = colors.purple }
        highlights.WhichKeyFloat = { bg = colors.bg }
        highlights.WhichKeyBorder = { fg = colors.cyan, bg = colors.bg }

        -- Completion menu
        highlights.CmpItemAbbr = { fg = colors.fg }
        highlights.CmpItemAbbrDeprecated = { fg = colors.fg_gutter, strikethrough = true }
        highlights.CmpItemAbbrMatch = { fg = colors.cyan, bold = true }
        highlights.CmpItemAbbrMatchFuzzy = { fg = colors.cyan, bold = true }
        highlights.CmpItemKind = { fg = colors.pink }
        highlights.CmpItemMenu = { fg = colors.orange }

        -- Special enhancements
        highlights.Title = { fg = colors.cyan, bold = true }
        highlights.Underlined = { fg = colors.blue, underline = true }
        highlights.Debug = { fg = colors.orange }
        highlights.Tag = { fg = colors.purple }

        -- Better contrast for special cases
        highlights.DiffAdd = { fg = colors.green, bg = "#1a2a1a" }
        highlights.DiffChange = { fg = colors.yellow, bg = "#2a2a1a" }
        highlights.DiffDelete = { fg = colors.red, bg = "#2a1a1a" }
        highlights.DiffText = { fg = colors.orange, bg = "#2a2a1a" }
      end,
    },
  },
}
