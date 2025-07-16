-- Code formatting
return {
  -- Enable none-ls extra for LazyVim compatibility
  { import = "lazyvim.plugins.extras.lsp.none-ls" },

  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
      formatters_by_ft = {
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        cpp = { "clang_format" },
        c = { "clang_format" },
        java = { "google-java-format" },
        python = { "black" },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "stylua",
          "prettierd",
          "prettier",
          "clang_format",
          "google-java-format",
          "black",
        },
        automatic_installation = true,
      })
    end,
  },
}
