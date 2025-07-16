-- Web development specific plugins
return {
  -- 🏷️ HTML TAG AUTO-CLOSE: Automatically close HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    -- What it does: Auto-closes <div> when you type </div>
    -- Works with: HTML, JSX, TSX, Vue
    ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- 🎨 COLOR PREVIEW: See colors in CSS/HTML
  {
    "norcalli/nvim-colorizer.lua",
    -- What it does: Shows actual colors for #ff0000, rgb(), etc.
    -- Features: Live preview of colors in code
    ft = { "css", "scss", "html", "javascript", "typescript" },
    config = function()
      require("colorizer").setup({
        "css",
        "scss",
        "html",
        "javascript",
        "typescript",
      })
    end,
  },

  -- ⚡ EMMET: Fast HTML/CSS writing
  {
    "mattn/emmet-vim",
    -- What it does: Type "div.container" + Ctrl+Z+, = <div class="container"></div>
    -- Features: Super fast HTML/CSS generation
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-z>"
    end,
  },

  -- 📦 PACKAGE.JSON HELPER: Shows package versions (FIXED loading issue)
  {
    "vuki656/package-info.nvim",
    -- What it does: Shows latest versions in package.json
    -- Features: Update packages, show outdated versions
    ft = "json",
    event = "VeryLazy", -- Load very late to avoid conflicts
    config = function()
      require("package-info").setup()
    end,
  },
}
