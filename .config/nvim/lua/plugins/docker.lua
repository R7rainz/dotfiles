return {
  -- Docker support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },

  -- Treesitter for Docker
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "dockerfile",
      })
      -- Enable treesitter-based indentation
      opts.indent = opts.indent or {}
      opts.indent.enable = true
    end,
  },

  -- Mason tools for Docker
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "dockerfile-language-server",
        "docker-compose-language-service",
        "hadolint",
      })
    end,
  },
}
