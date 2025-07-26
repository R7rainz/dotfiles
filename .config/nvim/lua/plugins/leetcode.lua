return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- This should work if nvim-treesitter is properly installed
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Make sure treesitter is included
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },
}
