return {
  -- Disable indent-blankline vertical lines
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  -- Disable mini.indentscope animations/lines (correct plugin name)
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },
  -- Configure snacks (enable dashboard, disable indent/scope)
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      scope = { enabled = false },
      dashboard = { enabled = true },
    },
  },
}
