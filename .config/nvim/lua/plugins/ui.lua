return {
  -- Disable indent-blankline vertical lines
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  -- Disable mini.indentscope animations/lines
  {
    "nvim-mini/mini.indentscope",
    enabled = false,
  },

  -- Disable snacks.nvim indent guides and scope
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      scope = { enabled = false },
    },
  },
}
