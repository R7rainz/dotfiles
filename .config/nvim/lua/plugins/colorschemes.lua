return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        inverse = true,
        contrast = "hard",
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
    end,
  },

  {
    "tiagovla/tokyodark.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent_background = true,
      gamma = 1.0,
      terminal_colors = true,
    },
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        styles = { transparency = true },
        highlight_groups = {
          TelescopeBorder = { fg = "highlight_high", bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopePromptNormal = { bg = "base" },
          TelescopeResultsNormal = { fg = "subtle", bg = "none" },
          TelescopeSelection = { fg = "text", bg = "base" },
          TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        },
      })
    end,
  },

  {
    "navarasu/onedark.nvim",
    name = "onedark",
    lazy = true,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker",
        transparent = true,
        term_colors = true,
        code_style = {
          comments = "italic",
          keywords = "none",
          functions = "none",
          strings = "none",
          variables = "none",
        },
      })
    end,
  },

  {
    "vague-theme/vague.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("vague").setup({
        transparent = true,
        style = {
          boolean = "none",
          number = "none",
          float = "none",
          error = "none",
          comments = "italic",
          conditionals = "none",
          functions = "none",
          headings = "bold",
          operators = "none",
          strings = "none",
          variables = "none",
        },
      })
    end,
  },

  {
    "oxfist/night-owl.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("night-owl").setup({
        transparent = true,
      })
    end,
  },

  {
    "polirritmico/monokai-nightasty.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("monokai-nightasty").setup({
        transparent_background = true,
        terminal_colors = true,
        hl_styles = {
          comments = { italic = true },
          keywords = { italic = false },
          functions = {},
          variables = {},
        },
      })
    end,
  },

  {
    "uhs-robert/oasis.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("oasis").setup({
        themed_syntax = true,
        transparent = true,
        terminal_colors = true,
        italic = true,
        underline = true,
        undercurl = true,
      })
    end,
  },
}
