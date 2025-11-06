return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      require("telescope").setup({ defaults = { file_ignore_patterns = { "node_modules" } } })
    end,
  },
}
