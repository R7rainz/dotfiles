-- C++ and Java specific plugins
return {
  -- 🔧 C++ ENHANCED HIGHLIGHTING: Better C++ syntax colors
  {
    "octol/vim-cpp-enhanced-highlight",
    -- What it does: More detailed C++ syntax highlighting
    -- Features: STL containers, member functions, etc.
    ft = { "cpp", "c" },
  },

  -- 🛠️ CLANG FORMAT: Code formatting with clang-format
  {
    "rhysd/vim-clang-format",
    -- What it does: Integrates clang-format for C++ code formatting
    -- Features: Manual code formatting (use :ClangFormat)
    ft = { "cpp", "c" },
    config = function()
      -- Disable auto format to prevent issues
      vim.g["clang_format#auto_format"] = 0
      vim.g["clang_format#style_options"] = {
        AccessModifierOffset = -2,
        AllowShortIfStatementsOnASingleLine = true,
        AlwaysBreakTemplateDeclarations = true,
        Standard = "C++11",
      }
    end,
  },

  -- 🔍 CLANGD LSP: Modern C++ language server
  {
    "p00f/clangd_extensions.nvim",
    -- What it does: Enhanced clangd LSP features
    -- Features: Better C++ completions, diagnostics, refactoring
    ft = { "cpp", "c" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("clangd_extensions").setup({
        server = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        extensions = {
          -- Enable clangd extensions
          autoSetHints = true,
          inlay_hints = {
            inline = vim.fn.has("nvim-0.10") == 1,
            only_current_line = false,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
            priority = 100,
          },
        },
      })
    end,
  },

  -- 🏗️ BUILD SYSTEM: Alternative build integration
  {
    "tpope/vim-dispatch",
    -- What it does: Asynchronous build system
    -- Features: Run make, compile commands in background
    ft = { "cpp", "c" },
    cmd = { "Make", "Dispatch", "Focus", "Start" },
  },

  -- 🐛 DEBUGGING: C++ debugging support
  {
    "mfussenegger/nvim-dap",
    -- What it does: Debug Adapter Protocol support
    -- Features: Set breakpoints, step through code
    ft = { "cpp", "c" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")

      -- GDB configuration for C++
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
      }

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
      }

      dap.configurations.c = dap.configurations.cpp
    end,
  },

  -- ☕ JAVA LSP: Advanced Java support
  {
    "mfussenegger/nvim-jdtls",
    -- What it does: Eclipse JDT language server for Java
    -- Features: Advanced Java completions, refactoring
    ft = "java",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
