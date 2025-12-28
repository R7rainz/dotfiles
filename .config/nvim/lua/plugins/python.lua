return {
  -- Python development
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
              },
            },
          },
        },
        ruff_lsp = {
          init_options = {
            settings = {
              args = {},
            },
          },
        },
      },
    },
  },

  -- Python debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          local ok, mason_registry = pcall(require, "mason-registry")
          if ok then
            local debugpy_ok, debugpy = pcall(mason_registry.get_package, mason_registry, "debugpy")
            if debugpy_ok and debugpy:is_installed() then
              require("dap-python").setup(debugpy:get_install_path() .. "/venv/bin/python")
              return
            end
          end
          -- Fallback to system python
          require("dap-python").setup("python3")
        end,
      },
    },
  },

  -- Python testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = { justMyCode = false },
          runner = "pytest",
        },
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
        "ninja",
        "rst",
      })
      -- Enable treesitter-based indentation
      opts.indent = opts.indent or {}
      opts.indent.enable = true
    end,
  },

  -- Mason tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "ruff-lsp",
        "debugpy",
        "black",
        "isort",
        "pylint",
        "mypy",
      })
    end,
  },

  -- Virtual environment selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    opts = {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
    },
    event = "VeryLazy",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },
}
