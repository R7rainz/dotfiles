-- Fix LazyVim import order
return {
  spec = {
    -- LazyVim should be first
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Then any LazyVim extras
    { import = "lazyvim.plugins.extras.lsp.none-ls" },

    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
