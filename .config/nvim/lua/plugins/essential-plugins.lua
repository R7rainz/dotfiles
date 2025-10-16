-- Core essential plugins with explanations
return {
  -- 🔍 FUZZY FINDER: Find files, search text, etc.
  {
    "nvim-telescope/telescope.nvim",
    -- What it does: Fuzzy finder for files, text, commands
    -- Keybinds: <leader>ff (find files), <leader>fg (search text)
    -- Features: Live grep, recent files, help tags
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
  },

  -- 🌳 SYNTAX HIGHLIGHTING: Better code colors
  {
    "nvim-treesitter/nvim-treesitter",
    -- What it does: Advanced syntax highlighting for all languages
    -- Features: Better colors, code folding, text objects
    -- Auto-installs parsers for JS, TS, HTML, CSS, etc.
    build = ":TSUpdate",
  },

  -- 💡 AUTOCOMPLETION: Smart code suggestions
  {
    "hrsh7th/nvim-cmp",
    -- What it does: Shows completion popup as you type
    -- Features: Function signatures, variable names, snippets
    -- Works with: LSP, file paths, buffers
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completions
      "hrsh7th/cmp-buffer", -- Buffer text completions
      "hrsh7th/cmp-path", -- File path completions
      "L3MON4D3/LuaSnip", -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
    },
  },

  -- 🔧 LSP: Language servers for error checking and features
  {
    "neovim/nvim-lspconfig",
    -- What it does: Connects to language servers (TypeScript, Python, etc.)
    -- Features: Error checking, go to definition, hover info
    -- Supports: All major programming languages
  },

  -- 📦 PACKAGE MANAGER: Install language servers and formatters
  {
    "mason-org/mason.nvim",
    -- What it does: GUI to install LSP servers, formatters, linters
    -- Command: :Mason to open the installer
    -- Auto-installs: TypeScript server, Prettier, ESLint, etc.
  },

  -- 🎯 AUTO PAIRS: Automatically close brackets and quotes
  -- (Already configured above with fix)

  -- 💬 COMMENTS: Smart commenting
  {
    "numToStr/Comment.nvim",
    -- What it does: Toggle comments with gcc (line) or gc (visual)
    -- Features: Works with all languages, respects syntax
    -- Keybinds: gcc, gc, gbc
  },

  -- 📏 INDENT GUIDES: Visual indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    -- What it does: Shows vertical lines for indentation levels
    -- Features: Helps see code structure, customizable colors
  },

  -- 🔍 WHICH-KEY: Shows available keybindings
  {
    "folke/which-key.nvim",
    -- What it does: Popup showing available key combinations
    -- Features: Press <leader> and see all options
    -- Helps: Learn keybindings, discover features
  },

  -- 📋 BUFFER LINE: Tab-like interface for open files
  {
    "akinsho/bufferline.nvim",
    -- What it does: Shows open files as tabs at the top
    -- Features: Close buttons, git status, file icons
    -- Keybinds: <S-h>/<S-l> to navigate tabs
  },

  -- 🔄 GIT INTEGRATION: Git changes in the editor
  {
    "lewis6991/gitsigns.nvim",
    -- What it does: Shows git changes in the gutter
    -- Features: Stage hunks, blame lines, diff view
    -- Visual: Green (+), orange (~), red (-) for changes
  },

  -- 🚨 DIAGNOSTICS: Better error/warning display
  {
    "folke/trouble.nvim",
    -- What it does: Panel showing all errors/warnings in project
    -- Keybind: <leader>xx to toggle
    -- Features: Jump to errors, filter by type
  },

  -- ✨ FORMATTING: Auto-format code on save
  {
    "stevearc/conform.nvim",
    -- What it does: Formats code using Prettier, Black, etc.
    -- Features: Format on save, multiple formatters per language
    -- Supports: JS/TS, Python, HTML, CSS, JSON
  },
}
