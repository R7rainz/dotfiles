-- Colorschemes Plugin Configuration
-- No theme is forced here.

return {

    {
        "philosofonusus/morta.nvim",
        name = "morta",
        lazy = true,
        priority = 1000,
        opts = {
            styles = {
                transparency = true,
                italic = true,
                bold = false,
            },
        },
    },

    {
        "sainnhe/gruvbox-material",
        lazy = true,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_foreground = "material" -- change to mix/original if you want
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_enable_bold = true
        end,
    },

    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            transparent = true,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                sidebars = "dark",
                floats = "dark",
            },
            on_colors = function(colors)
                -- Core backgrounds
                colors.bg = "#1a1b26"
                colors.bg_dark = "#16161e"
                colors.bg_float = "#16161e"
                colors.bg_sidebar = "#1d1f2d"
                colors.bg_statusline = "#1d1f2d"
                colors.bg_popup = "#1d1f2d"
                -- Foreground
                colors.fg = "#c0caf5"
                colors.fg_dark = "#a9b1d6"
                colors.fg_gutter = "#484b5c"
                -- UI
                colors.border = "#414868"
                colors.comment = "#627082"
                colors.accent = "#7aa2f7"
                -- Base colors
                colors.blue = "#7aa2f7"
                colors.cyan = "#7dcfff"
                colors.green = "#9ece6a"
                colors.magenta = "#bb9af7"
                colors.orange = "#ff9e64"
                colors.purple = "#bb9af7"
                colors.red = "#f77676"
                colors.yellow = "#e0af68"
                -- Git
                colors.git = {
                    add = "#81b88b",
                    change = "#e2c08d",
                    delete = "#c74e39",
                }
                colors.gitSigns = {
                    add = "#5b8430",
                    change = "#7aa2f7",
                    delete = "#d54242",
                }
                -- Search / Visual
                colors.bg_search = "#414868"
                colors.bg_visual = "#1f253f"
                colors.bg_highlight = "#202437"
                -- Diff (solid equivalents of VS Code alpha colors)
                colors.bg_diff_add = "#1f3d2b"
                colors.bg_diff_delete = "#3d1f25"
                colors.bg_diff_change = "#3a2f1a"
                colors.bg_diff_text = "#4a3b1f"
            end,
        },
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        priority = 1000,
        opts = {
            flavour = "mocha",
            transparent_background = true,
            styles = {
                comments = { "italic" },
                keywords = { "italic" },
            },
            color_overrides = {
                mocha = {
                    -- Editor & UI Backgrounds
                    base = "#121314", -- editor.background
                    mantle = "#191a1b", -- sideBar.background / terminal.background
                    crust = "#0f1011", -- Deepest background (slightly darker than base)

                    -- UI Foregrounds & Borders
                    text = "#bfbfbf", -- foreground
                    subtext1 = "#bbbebf", -- editor.foreground
                    subtext0 = "#a0a0a0",
                    overlay2 = "#8c8c8c", -- descriptionForeground / inactive elements
                    overlay1 = "#858889", -- editorLineNumber.foreground
                    overlay0 = "#555555", -- disabledForeground
                    surface2 = "#333536", -- input.border
                    surface1 = "#2a2b2c", -- activityBar.border / tab.border
                    surface0 = "#202122", -- editorWidget.background / menus

                    -- Syntax & Accent Colors
                    blue = "#569CD6", -- keyword / constant.language
                    sapphire = "#3994bc", -- activityBarBadge (UI Accent)
                    sky = "#9CDCFE", -- variable.other / object keys
                    teal = "#4EC9B0", -- support.class / types
                    green = "#73c991", -- git added / strings
                    yellow = "#e5ba7d", -- warnings / git modified
                    peach = "#FFA657", -- markup/variables
                    maroon = "#CE9178", -- string.value
                    red = "#f48771", -- errorForeground
                    mauve = "#D2A8FF", -- entity.name.function
                    pink = "#C586C0", -- keyword.control
                    flamingo = "#D16969", -- string.regexp
                    rosewater = "#f28772", -- editorGutter.deleted
                },
            },
            custom_highlights = function(colors)
                return {
                    -- Syntax adjustments
                    Comment = { fg = "#8B949E", style = { "italic" } },
                    String = { fg = "#CE9178" },
                    Keyword = { fg = "#569CD6", style = { "italic" } },
                    Function = { fg = "#DCDCAA", style = { "italic" } },
                    Type = { fg = "#4EC9B0" },
                    Variable = { fg = "#9CDCFE" },
                    Constant = { fg = "#79C0FF" },
                    Number = { fg = "#B5CEA8" },
                    Boolean = { fg = "#569CD6" },

                    -- Editor UI
                    LineNr = { fg = colors.overlay1 },
                    CursorLineNr = { fg = colors.subtext1 },
                    CursorLine = { bg = "#242526" },
                    ColorColumn = { bg = "#242526" },

                    -- Selections
                    Visual = { bg = "#276782" },
                    Search = { bg = "#276782", fg = colors.text },
                    IncSearch = { bg = "#3994bc", fg = colors.base },

                    -- Popups / Menus
                    Pmenu = { bg = colors.surface0, fg = colors.text },
                    PmenuSel = { bg = "#3994bc", fg = "#ffffff" },
                    PmenuSbar = { bg = colors.surface1 },
                    PmenuThumb = { bg = colors.overlay0 },

                    -- Telescope
                    TelescopeNormal = { bg = colors.surface0 },
                    TelescopeBorder = { bg = colors.surface0, fg = colors.surface1 },
                    TelescopePromptNormal = { bg = colors.mantle },
                    TelescopePromptBorder = { bg = colors.mantle, fg = colors.surface1 },

                    -- Tree Explorers
                    NvimTreeNormal = { bg = colors.mantle },
                    NvimTreeWinSeparator = { fg = colors.surface1 },

                    -- Diagnostics
                    DiagnosticError = { fg = colors.red },
                    DiagnosticWarn = { fg = colors.yellow },
                    DiagnosticInfo = { fg = colors.sapphire },
                    DiagnosticHint = { fg = colors.overlay2 },
                }
            end,
        },
    },

    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            transparent = false,
            commentStyle = { italic = true },
            keywordStyle = { italic = true },
        },
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        priority = 1000,
        opts = {
            styles = {
                transparency = true,
                italic = true,
            },
        },
    },

    {
        "navarasu/onedark.nvim",
        name = "onedark",
        lazy = true,
        priority = 1000,
        opts = {
            style = "cool",
            transparent = false,
        },
    },

    {
        "craftzdog/solarized-osaka.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            transparent = false,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
            },
            dim_inactive = true,
        },
    },

    {
        "tiagovla/tokyodark.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            transparent_background = false,
        },
    },
}
