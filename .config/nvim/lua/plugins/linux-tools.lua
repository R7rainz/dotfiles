return {
  -- Bash/Shell scripting support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
      },
    },
  },

  -- Treesitter for Linux/Shell
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "fish",
        "make",
        "cmake",
        "ninja",
        "toml",
        "yaml",
        "ini",
      })
      -- Enable treesitter-based indentation
      opts.indent = opts.indent or {}
      opts.indent.enable = true
    end,
  },

  -- Mason tools for Linux development
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "bash-language-server",
        "shellcheck",
        "shfmt",
        "yamllint",
        "yamlfmt",
        "actionlint",
      })
    end,
  },

  -- Better terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<c-`>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    },
  },
}
