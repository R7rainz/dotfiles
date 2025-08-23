return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true, bold = true },
        functions = { bold = true },
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "packer", "neo-tree" },
      on_colors = function(colors)
        -- Match Kitty Dracula background colors
        colors.bg = "#000000" -- Pure black background
        colors.bg_dark = "#121212" -- Slightly lighter black
        colors.bg_float = "#1a1a1a"
        colors.bg_highlight = "#282a36" -- Kitty's active tab background
        colors.bg_popup = "#1a1a1a"
        colors.bg_sidebar = "#000000"
        colors.bg_statusline = "#1a1a1a"
        colors.bg_visual = "#44475a" -- Kitty's inactive border color

        -- Text colors matching Kitty
        colors.fg = "#f8f8f2" -- Kitty foreground
        colors.fg_dark = "#e6edf3"
        colors.fg_gutter = "#6272a4" -- Kitty color8
        colors.fg_sidebar = "#f8f8f2"

        -- Kitty Dracula color palette
        colors.red = "#ff5555" -- Kitty red
        colors.red1 = "#ff6e6e" -- Kitty bright red
        colors.red2 = "#cc1f1f"
        colors.crimson = "#ff5555"
        colors.coral = "#ff6e6e"

        colors.cyan = "#8be9fd" -- Kitty cyan
        colors.teal = "#20b2aa"
        colors.orange = "#ffb86c" -- Kitty orange
        colors.pink = "#ff79c6" -- Kitty pink/magenta
        colors.white = "#ffffff"
        colors.silver = "#c0c0c0"

        colors.blue = "#bd93f9" -- Kitty blue/purple
        colors.green = "#50fa7b" -- Kitty green

        -- UI colors matching Kitty
        colors.border = "#44475a" -- Kitty inactive border
        colors.border_highlight = "#ff79c6" -- Kitty active border

        -- Diagnostic colors matching Kitty
        colors.error = "#ff5555" -- Kitty red
        colors.warning = "#ffb86c" -- Kitty orange
        colors.info = "#8be9fd" -- Kitty cyan
        colors.hint = "#ff79c6" -- Kitty pink
      end,
      on_highlights = function(highlights, colors)
        -- Background overrides (matching Kitty)
        highlights.Normal = { fg = colors.fg, bg = colors.bg }
        highlights.NormalFloat = { fg = colors.fg, bg = colors.bg_float }
        highlights.NormalNC = { fg = colors.fg, bg = colors.bg }
        highlights.SignColumn = { bg = colors.bg }
        highlights.EndOfBuffer = { fg = colors.bg }

        -- Cursor and selection (Kitty-inspired)
        highlights.CursorLine = { bg = colors.bg_highlight }
        highlights.CursorColumn = { bg = colors.bg_highlight }
        highlights.Visual = { bg = colors.bg_visual }
        highlights.VisualNOS = { bg = colors.bg_visual }

        -- Line numbers
        highlights.LineNr = { fg = colors.fg_gutter }
        highlights.CursorLineNr = { fg = colors.pink, bold = true } -- Kitty pink

        -- Search (Kitty colors)
        highlights.Search = { bg = colors.pink, fg = "#000000", bold = true } -- Kitty pink
        highlights.IncSearch = { bg = colors.orange, fg = "#000000", bold = true } -- Kitty orange
        highlights.CurSearch = { bg = colors.red, fg = "#000000", bold = true } -- Kitty red

        -- Syntax highlighting matching Kitty theme
        highlights.Comment = { fg = colors.fg_gutter, italic = true } -- Kitty color8
        highlights.Keyword = { fg = colors.pink, bold = true } -- Kitty pink
        highlights.Function = { fg = colors.green, bold = true } -- Kitty green
        highlights.String = { fg = colors.orange } -- Kitty orange
        highlights.Number = { fg = colors.orange } -- Kitty orange
        highlights.Boolean = { fg = colors.orange } -- Kitty orange
        highlights.Constant = { fg = colors.red } -- Kitty red
        highlights.Variable = { fg = colors.fg }
        highlights.Type = { fg = colors.blue } -- Kitty blue/purple
        highlights.Operator = { fg = colors.pink } -- Kitty pink
        highlights.Special = { fg = colors.cyan } -- Kitty cyan
        highlights.Identifier = { fg = colors.fg }
        highlights.PreProc = { fg = colors.pink } -- Kitty pink
        highlights.Include = { fg = colors.pink } -- Kitty pink
        highlights.Define = { fg = colors.pink } -- Kitty pink
        highlights.Macro = { fg = colors.pink } -- Kitty pink
        highlights.StorageClass = { fg = colors.pink, bold = true } -- Kitty pink
        highlights.Structure = { fg = colors.blue } -- Kitty blue
        highlights.Typedef = { fg = colors.blue } -- Kitty blue

        -- Language specific highlighting
        highlights["@keyword.function"] = { fg = colors.pink, bold = true }
        highlights["@keyword.return"] = { fg = colors.pink, bold = true }
        highlights["@keyword.operator"] = { fg = colors.pink }
        highlights["@variable.builtin"] = { fg = colors.cyan } -- Kitty cyan
        highlights["@property"] = { fg = colors.green } -- Kitty green
        highlights["@parameter"] = { fg = colors.fg }
        highlights["@constructor"] = { fg = colors.blue, bold = true } -- Kitty blue
        highlights["@tag"] = { fg = colors.pink } -- Kitty pink
        highlights["@tag.attribute"] = { fg = colors.orange } -- Kitty orange
        highlights["@tag.delimiter"] = { fg = colors.pink } -- Kitty pink

        -- HTML
        highlights.htmlTag = { fg = colors.pink }
        highlights.htmlEndTag = { fg = colors.pink }
        highlights.htmlTagName = { fg = colors.pink }
        highlights.htmlArg = { fg = colors.orange }
        highlights.htmlString = { fg = colors.orange }

        -- CSS
        highlights.cssProp = { fg = colors.cyan } -- Kitty cyan
        highlights.cssAttr = { fg = colors.orange } -- Kitty orange
        highlights.cssValueLength = { fg = colors.orange }
        highlights.cssValueNumber = { fg = colors.orange }
        highlights.cssClassName = { fg = colors.green } -- Kitty green
        highlights.cssIdentifier = { fg = colors.blue } -- Kitty blue

        -- React/JSX
        highlights["@tag.tsx"] = { fg = colors.pink }
        highlights["@constructor.tsx"] = { fg = colors.blue, bold = true }
        highlights["@tag.attribute.tsx"] = { fg = colors.orange }

        -- Popup menus (Kitty-inspired)
        highlights.Pmenu = { fg = colors.fg, bg = colors.bg_float }
        highlights.PmenuSel = { fg = "#000000", bg = colors.pink } -- Kitty pink
        highlights.PmenuSbar = { bg = colors.bg_float }
        highlights.PmenuThumb = { bg = colors.pink }

        -- Statusline
        highlights.StatusLine = { fg = colors.fg, bg = colors.bg_float }
        highlights.StatusLineNC = { fg = colors.fg_dark, bg = colors.bg }

        -- Tabline
        highlights.TabLine = { fg = colors.fg_dark, bg = colors.bg }
        highlights.TabLineFill = { bg = colors.bg }
        highlights.TabLineSel = { fg = colors.pink, bg = colors.bg_float, bold = true } -- Kitty pink

        -- Splits
        highlights.VertSplit = { fg = colors.border }
        highlights.WinSeparator = { fg = colors.border }

        -- Git signs
        highlights.GitSignsAdd = { fg = colors.green } -- Kitty green
        highlights.GitSignsChange = { fg = colors.orange } -- Kitty orange
        highlights.GitSignsDelete = { fg = colors.red } -- Kitty red

        -- Diagnostics
        highlights.DiagnosticError = { fg = colors.error }
        highlights.DiagnosticWarn = { fg = colors.warning }
        highlights.DiagnosticInfo = { fg = colors.info }
        highlights.DiagnosticHint = { fg = colors.hint }

        -- LSP
        highlights.LspReferenceText = { bg = colors.bg_visual }
        highlights.LspReferenceRead = { bg = colors.bg_visual }
        highlights.LspReferenceWrite = { bg = colors.bg_visual }

        -- Telescope (Kitty colors)
        highlights.TelescopeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.TelescopeBorder = { fg = colors.pink, bg = colors.bg } -- Kitty pink
        highlights.TelescopePromptBorder = { fg = colors.pink, bg = colors.bg }
        highlights.TelescopeResultsBorder = { fg = colors.pink, bg = colors.bg }
        highlights.TelescopePreviewBorder = { fg = colors.pink, bg = colors.bg }
        highlights.TelescopeSelection = { fg = colors.fg, bg = colors.bg_visual }
        highlights.TelescopeSelectionCaret = { fg = colors.pink }
        highlights.TelescopePromptPrefix = { fg = colors.pink }
        highlights.TelescopeMatching = { fg = colors.cyan, bold = true } -- Kitty cyan

        -- Neo-tree
        highlights.NeoTreeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeDirectoryName = { fg = colors.cyan } -- Kitty cyan
        highlights.NeoTreeDirectoryIcon = { fg = colors.cyan }
        highlights.NeoTreeFileName = { fg = colors.fg }
        highlights.NeoTreeFileIcon = { fg = colors.orange } -- Kitty orange
        highlights.NeoTreeGitAdded = { fg = colors.green } -- Kitty green
        highlights.NeoTreeGitModified = { fg = colors.orange } -- Kitty orange
        highlights.NeoTreeGitDeleted = { fg = colors.red } -- Kitty red
        highlights.NeoTreeRootName = { fg = colors.pink, bold = true } -- Kitty pink

        -- Which-key
        highlights.WhichKey = { fg = colors.pink } -- Kitty pink
        highlights.WhichKeyGroup = { fg = colors.cyan } -- Kitty cyan
        highlights.WhichKeyDesc = { fg = colors.fg }
        highlights.WhichKeySeperator = { fg = colors.pink } -- Kitty pink
        highlights.WhichKeyFloat = { bg = colors.bg }
        highlights.WhichKeyBorder = { fg = colors.pink, bg = colors.bg }

        -- Indent guides
        highlights.IndentBlanklineChar = { fg = colors.border }
        highlights.IndentBlanklineContextChar = { fg = colors.pink } -- Kitty pink

        -- Bufferline
        highlights.BufferLineBackground = { fg = colors.fg_dark, bg = colors.bg }
        highlights.BufferLineBuffer = { fg = colors.fg_dark, bg = colors.bg }
        highlights.BufferLineBufferSelected = { fg = colors.pink, bg = colors.bg_float, bold = true } -- Kitty pink
        highlights.BufferLineBufferVisible = { fg = colors.fg, bg = colors.bg }
        highlights.BufferLineFill = { bg = colors.bg }
        highlights.BufferLineIndicatorSelected = { fg = colors.pink, bg = colors.bg_float }
        highlights.BufferLineModified = { fg = colors.orange, bg = colors.bg }
        highlights.BufferLineModifiedSelected = { fg = colors.orange, bg = colors.bg_float }
        highlights.BufferLineCloseButton = { fg = colors.fg_dark, bg = colors.bg }
        highlights.BufferLineCloseButtonSelected = { fg = colors.pink, bg = colors.bg_float }

        -- Completion menu
        highlights.CmpItemAbbr = { fg = colors.fg }
        highlights.CmpItemAbbrDeprecated = { fg = colors.fg_gutter, strikethrough = true }
        highlights.CmpItemAbbrMatch = { fg = colors.pink, bold = true } -- Kitty pink
        highlights.CmpItemAbbrMatchFuzzy = { fg = colors.pink, bold = true }
        highlights.CmpItemKind = { fg = colors.cyan } -- Kitty cyan
        highlights.CmpItemMenu = { fg = colors.orange } -- Kitty orange

        -- Treesitter context
        highlights.TreesitterContext = { bg = colors.bg_float }
        highlights.TreesitterContextLineNumber = { fg = colors.fg_gutter, bg = colors.bg_float }
      end,
    },
  },
}
