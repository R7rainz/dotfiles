return {
  {
    "metalelf0/black-metal-theme-neovim",
    priority = 1000,
    lazy = false,
    config = function()
      require("black-metal").setup({
        theme = "impaled-nazarene", -- <- change to any other band if needed
        variant = "dark",
        transparent = false,
        term_colors = true,
        code_style = {
          comments = "italic",
          keywords = "bold",
          functions = "none",
        },
        plugin = {
          lualine = {
            bold = true,
          },
        },
      })
      require("black-metal").load()
    end,
  },
}
