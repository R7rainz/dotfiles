return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup({
        "*",
        css = { rgb_fn = true },
        html = { rgb_fn = true },
      })
    end,
  },
}
