--[[
  Python Plugin Configuration
  --------------------------
  All Python LSP, DAP, testing, and related plugin setups.
  Add or modify Python-specific plugins here.
]]
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
