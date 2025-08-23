-- Red-focused colorscheme with black background and complementary colors
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
        -- Pure black background
        colors.bg = "#000000"
        colors.bg_dark = "#000000"
        colors.bg_float = "#000000"
        colors.bg_highlight = "#111111"
        colors.bg_popup = "#000000"
        colors.bg_sidebar = "#000000"
        colors.bg_statusline = "#000000"
        colors.bg_visual = "#4a1a1a" -- Dark red for visual selection

        -- Red-focused color palette with complementary colors
        colors.fg = "#e8e8e8" -- Light gray for main text
        colors.fg_dark = "#d0d0d0" -- Slightly darker gray
        colors.fg_gutter = "#555555" -- Medium gray for line numbers
        colors.fg_sidebar = "#e8e8e8" -- Light gray for sidebar

        -- Primary red colors (various shades)
        colors.red = "#ff2d2d" -- Bright red (main accent)
        colors.red1 = "#ff4444" -- Lighter red
        colors.red2 = "#cc1f1f" -- Darker red
        colors.crimson = "#dc143c" -- Crimson red
        colors.coral = "#ff6b6b" -- Coral red

        -- Complementary colors (limited greens/blues, keeping cyan)
        colors.cyan = "#00ffff" -- Bright cyan (you like this)
        colors.teal = "#20b2aa" -- Teal (cyan-ish, for structures)
        colors.orange = "#ff8c42" -- Warm orange (for numbers, warnings)
        colors.pink = "#ff69b4" -- Hot pink (for operators, hints)
        colors.white = "#ffffff" -- Pure white
        colors.silver = "#c0c0c0" -- Silver (for identifiers)

        -- Minimal blues/greens (just accents for specific elements)
        colors.blue = "#4169e1" -- Royal blue (minimal use, e.g., some types)
        colors.green = "#32cd32" -- Lime green (minimal use, e.g., git additions)

        -- UI colors
        colors.border = "#555555"
        colors.border_highlight = "#ff2d2d"

        -- Diagnostic colors (red-focused)
        colors.error = "#ff2d2d"
        colors.warning = "#ff8c42"
        colors.info = "#00ffff"
        colors.hint = "#ff69b4"
      end,
      on_highlights = function(highlights, colors)
        -- Background overrides (pure black)
        highlights.Normal = { fg = colors.fg, bg = colors.bg }
        highlights.NormalFloat = { fg = colors.fg, bg = colors.bg }
        highlights.NormalNC = { fg = colors.fg, bg = colors.bg }
        highlights.SignColumn = { bg = colors.bg }
        highlights.EndOfBuffer = { fg = colors.bg }

        -- Cursor and selection
        highlights.CursorLine = { bg = "#111111" }
        highlights.CursorColumn = { bg = "#111111" }
        highlights.Visual = { bg = "#4a1a1a" }
        highlights.VisualNOS = { bg = "#4a1a1a" }

        -- Line numbers
        highlights.LineNr = { fg = "#555555" }
        highlights.CursorLineNr = { fg = colors.red, bold = true }

        -- Search
        highlights.Search = { bg = colors.red, fg = "#000000", bold = true }
        highlights.IncSearch = { bg = colors.orange, fg = "#000000", bold = true }
        highlights.CurSearch = { bg = colors.red, fg = "#000000", bold = true }

        -- Red-focused syntax highlighting
        highlights.Comment = { fg = "#888888", italic = true }
        highlights.Keyword = { fg = colors.red, bold = true } -- Bright red keywords
        highlights.Function = { fg = colors.cyan, bold = true } -- Cyan functions
        highlights.String = { fg = colors.coral } -- Coral strings
        highlights.Number = { fg = colors.orange } -- Orange numbers
        highlights.Boolean = { fg = colors.orange } -- Orange booleans
        highlights.Constant = { fg = colors.red1 } -- Light red constants
        highlights.Variable = { fg = colors.fg } -- Main text for variables
        highlights.Type = { fg = colors.cyan } -- Cyan types
        highlights.Operator = { fg = colors.pink } -- Pink operators
        highlights.Special = { fg = colors.red2 } -- Dark red special chars
        highlights.Identifier = { fg = colors.silver } -- Silver identifiers
        highlights.PreProc = { fg = colors.crimson } -- Crimson preprocessor
        highlights.Include = { fg = colors.red1 } -- Light red includes
        highlights.Define = { fg = colors.coral } -- Coral defines
        highlights.Macro = { fg = colors.red2 } -- Dark red macros
        highlights.StorageClass = { fg = colors.red, bold = true } -- Red storage class
        highlights.Structure = { fg = colors.teal } -- Teal structures
        highlights.Typedef = { fg = colors.cyan } -- Cyan typedefs

        -- Language specific highlighting
        -- JavaScript/TypeScript
        highlights["@keyword.function"] = { fg = colors.red, bold = true }
        highlights["@keyword.return"] = { fg = colors.crimson, bold = true }
        highlights["@keyword.operator"] = { fg = colors.pink }
        highlights["@variable.builtin"] = { fg = colors.coral }
        highlights["@property"] = { fg = colors.teal }
        highlights["@parameter"] = { fg = colors.silver }
        highlights["@constructor"] = { fg = colors.cyan, bold = true }
        highlights["@tag"] = { fg = colors.red }
        highlights["@tag.attribute"] = { fg = colors.orange }
        highlights["@tag.delimiter"] = { fg = colors.pink }

        -- HTML
        highlights.htmlTag = { fg = colors.pink }
        highlights.htmlEndTag = { fg = colors.pink }
        highlights.htmlTagName = { fg = colors.red }
        highlights.htmlArg = { fg = colors.orange }
        highlights.htmlString = { fg = colors.coral }

        -- CSS
        highlights.cssProp = { fg = colors.cyan }
        highlights.cssAttr = { fg = colors.orange }
        highlights.cssValueLength = { fg = colors.orange }
        highlights.cssValueNumber = { fg = colors.orange }
        highlights.cssClassName = { fg = colors.red1 }
        highlights.cssIdentifier = { fg = colors.teal }

        -- React/JSX
        highlights["@tag.tsx"] = { fg = colors.red }
        highlights["@constructor.tsx"] = { fg = colors.cyan, bold = true }
        highlights["@tag.attribute.tsx"] = { fg = colors.orange }

        -- Popup menus
        highlights.Pmenu = { fg = colors.fg, bg = "#1a1a1a" }
        highlights.PmenuSel = { fg = "#000000", bg = colors.red }
        highlights.PmenuSbar = { bg = "#1a1a1a" }
        highlights.PmenuThumb = { bg = colors.red }

        -- Statusline (LazyVim's default statusline will use these colors)
        highlights.StatusLine = { fg = colors.fg, bg = "#1a1a1a" }
        highlights.StatusLineNC = { fg = colors.fg_dark, bg = colors.bg }

        -- Tabline
        highlights.TabLine = { fg = colors.fg_dark, bg = colors.bg }
        highlights.TabLineFill = { bg = colors.bg }
        highlights.TabLineSel = { fg = colors.red, bg = "#1a1a1a", bold = true }

        -- Splits
        highlights.VertSplit = { fg = "#333333" }
        highlights.WinSeparator = { fg = "#333333" }

        -- Git signs
        highlights.GitSignsAdd = { fg = colors.green } -- Minimal green for additions
        highlights.GitSignsChange = { fg = colors.orange }
        highlights.GitSignsDelete = { fg = colors.red }

        -- Diagnostics
        highlights.DiagnosticError = { fg = colors.error }
        highlights.DiagnosticWarn = { fg = colors.warning }
        highlights.DiagnosticInfo = { fg = colors.info }
        highlights.DiagnosticHint = { fg = colors.hint }

        -- LSP
        highlights.LspReferenceText = { bg = "#4a1a1a" }
        highlights.LspReferenceRead = { bg = "#4a1a1a" }
        highlights.LspReferenceWrite = { bg = "#4a1a1a" }

        -- Telescope
        highlights.TelescopeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.TelescopeBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopePromptBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopeResultsBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopePreviewBorder = { fg = colors.red, bg = colors.bg }
        highlights.TelescopeSelection = { fg = colors.fg, bg = "#4a1a1a" }
        highlights.TelescopeSelectionCaret = { fg = colors.red }
        highlights.TelescopePromptPrefix = { fg = colors.red }
        highlights.TelescopeMatching = { fg = colors.cyan, bold = true }

        -- Neo-tree
        highlights.NeoTreeNormal = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg }
        highlights.NeoTreeDirectoryName = { fg = colors.cyan }
        highlights.NeoTreeDirectoryIcon = { fg = colors.cyan }
        highlights.NeoTreeFileName = { fg = colors.fg }
        highlights.NeoTreeFileIcon = { fg = colors.coral }
        highlights.NeoTreeGitAdded = { fg = colors.green }
        highlights.NeoTreeGitModified = { fg = colors.orange }
        highlights.NeoTreeGitDeleted = { fg = colors.red }
        highlights.NeoTreeRootName = { fg = colors.red, bold = true }

        -- Which-key
        highlights.WhichKey = { fg = colors.red }
        highlights.WhichKeyGroup = { fg = colors.cyan }
        highlights.WhichKeyDesc = { fg = colors.fg }
        highlights.WhichKeySeperator = { fg = colors.pink }
        highlights.WhichKeyFloat = { bg = colors.bg }
        highlights.WhichKeyBorder = { fg = colors.red, bg = colors.bg }

        -- Indent guides
        highlights.IndentBlanklineChar = { fg = "#333333" }
        highlights.IndentBlanklineContextChar = { fg = "#555555" }

        -- Bufferline
        highlights.BufferLineBackground = { fg = colors.fg_dark, bg = colors.bg }
        highlights.BufferLineBuffer = { fg = colors.fg_dark, bg = colors.bg }
        highlights.BufferLineBufferSelected = { fg = colors.red, bg = "#1a1a1a", bold = true }
        highlights.BufferLineBufferVisible = { fg = colors.fg, bg = colors.bg }
        highlights.BufferLineFill = { bg = colors.bg }
        highlights.BufferLineIndicatorSelected = { fg = colors.red, bg = "#1a1a1a" }
        highlights.BufferLineModified = { fg = colors.orange, bg = colors.bg }
        highlights.BufferLineModifiedSelected = { fg = colors.orange, bg = "#1a1a1a" }
        highlights.BufferLineCloseButton = { fg = colors.fg_dark, bg = colors.bg }
        highlights.BufferLineCloseButtonSelected = { fg = colors.red, bg = "#1a1a1a" }

        -- Trouble
        highlights.TroubleNormal = { fg = colors.fg, bg = colors.bg }
        highlights.TroubleText = { fg = colors.fg }
        highlights.TroubleCount = { fg = colors.red, bg = "#4a1a1a" }
        highlights.TroubleError = { fg = colors.error }
        highlights.TroubleWarning = { fg = colors.warning }
        highlights.TroubleInformation = { fg = colors.info }
        highlights.TroubleHint = { fg = colors.hint }

        -- Completion menu
        highlights.CmpItemAbbr = { fg = colors.fg }
        highlights.CmpItemAbbrDeprecated = { fg = colors.fg_gutter, strikethrough = true }
        highlights.CmpItemAbbrMatch = { fg = colors.red, bold = true }
        highlights.CmpItemAbbrMatchFuzzy = { fg = colors.red, bold = true }
        highlights.CmpItemKind = { fg = colors.cyan }
        highlights.CmpItemMenu = { fg = colors.coral }

        -- Treesitter context
        highlights.TreesitterContext = { bg = "#1a1a1a" }
        highlights.TreesitterContextLineNumber = { fg = colors.fg_gutter, bg = "#1a1a1a" }
      end,
    },
  },
}
