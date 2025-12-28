return {
  -- Go development setup
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        disable_defaults = true, -- Disable default keybindings to avoid conflicts
        go = "go",
        goimports = "gopls",
        fillstruct = "gopls",
        -- use golines so max_line_len takes effect
        gofmt = "golines",
        max_line_len = 120,
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = true,
        dap_debug = true,
      })
      
      -- Set custom Go keybindings that don't conflict with Telescope
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local opts = { buffer = true }
          -- Go-specific commands (using <leader>g prefix for Go)
          vim.keymap.set("n", "<leader>gf", "<cmd>GoFillStruct<cr>", vim.tbl_extend("force", opts, { desc = "Go Fill Struct" }))
          vim.keymap.set("n", "<leader>gi", "<cmd>GoIfErr<cr>", vim.tbl_extend("force", opts, { desc = "Go If Err" }))
          vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", vim.tbl_extend("force", opts, { desc = "Go Test" }))
          vim.keymap.set("n", "<leader>gT", "<cmd>GoTestFunc<cr>", vim.tbl_extend("force", opts, { desc = "Go Test Function" }))
          vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<cr>", vim.tbl_extend("force", opts, { desc = "Go Run" }))
          vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<cr>", vim.tbl_extend("force", opts, { desc = "Go Build" }))
          vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", vim.tbl_extend("force", opts, { desc = "Go Doc" }))
          vim.keymap.set("n", "<leader>ga", "<cmd>GoAlt<cr>", vim.tbl_extend("force", opts, { desc = "Go Alternate (test/impl)" }))
          vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<cr>", vim.tbl_extend("force", opts, { desc = "Go Coverage" }))
        end,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- LSP configuration for Go
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              -- Disable semantic tokens; let treesitter/colorscheme handle colors
              semanticTokens = false,
            },
          },
        },
      },
    },
  },

  -- DAP configuration for Go debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "delve" })
        end,
      },
      {
        "leoluz/nvim-dap-go",
        config = true,
      },
    },
  },

  -- Treesitter for Go
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "go",
        "gomod",
        "gowork",
        "gosum",
      })
      -- Enable treesitter-based indentation
      opts.indent = opts.indent or {}
      opts.indent.enable = true
    end,
  },

  -- Mason tools for Go
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "goimports",
        "gofumpt",
        "golines",
        "gomodifytags",
        "impl",
        "delve",
      })
    end,
  },

  -- Go testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          args = { "-count=1", "-timeout=60s" },
        },
      },
    },
  },
}
