-- Additional web development plugins
return {
  -- Emmet for HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-z>"
    end,
  },

  -- Auto close and rename HTML tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Color highlighter
  {
    "norcalli/nvim-colorizer.lua",
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

  -- Package.json helper
  {
    "vuki656/package-info.nvim",
    ft = "json",
    config = function()
      require("package-info").setup()
    end,
  },
}
