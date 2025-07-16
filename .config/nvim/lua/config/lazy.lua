-- Simplified LazyVim configuration without plugin duplication
return {
  spec = {
    -- LazyVim should be first
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- LazyVim extras (these already include mason and lsp configs)
    { import = "lazyvim.plugins.extras.lsp.none-ls" },

    -- Your custom plugins
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
