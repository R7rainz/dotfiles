return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        prisma = { "prisma_format" },
        go = { "goimports", "gofumpt" },
        gomod = { "goimports" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      local nvlsp = require "nvchad.configs.lspconfig"
      nvlsp.defaults()

      local servers = { "html", "cssls", "jsonls", "yamlls", "prismals",
        "emmet_language_server", "pyright", "rust_analyzer", "bashls",
        "dockerls", "marksman", "clangd" }

      for _, lsp in ipairs(servers) do
        vim.lsp.enable(lsp)
      end

      vim.lsp.config.gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        single_file_support = true,
        settings = {
          gopls = {
            analyses = { unusedparams = true, shadow = true },
            staticcheck = true, gofumpt = true,
            completeUnimported = true, usePlaceholders = true,
            hints = {
              assignVariableTypes = false, compositeLiteralFields = false,
              compositeLiteralTypes = false, constantValues = false,
              functionTypeParameters = false, parameterNames = false,
              rangeVariableTypes = false,
            },
          },
        },
      }
      vim.lsp.enable "gopls"

      require("typescript-tools").setup {
        settings = {
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "none",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = false,
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayEnumMemberValueHints = false,
          },
        },
      }

      vim.diagnostic.config {
        virtual_text = true, signs = true, underline = true,
        update_in_insert = false, severity_sort = true,
        float = { border = "rounded", source = "always" },
      }

      vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        config = config or {}
        config.border = "rounded"
        return vim.lsp.handlers.hover(err, result, ctx, config)
      end

      vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
        config = config or {}
        config.border = "rounded"
        return vim.lsp.handlers.signature_help(err, result, ctx, config)
      end
    end,
  },

  -- NvChad blink completion
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",

        -- web dev
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",

        -- backend / tools
        "bash",
        "dockerfile",
        "prisma",
        "go",
        "gomod",
        "gowork",
        "gosum",

        -- optional c/c++
        "c",
        "cpp",
      },
    },
  },

  -- auto close brackets/tags
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- better TypeScript support
  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },

  -- Tailwind CSS tools (install tailwindcss-language-server via :Mason to enable)
  -- {
  --   "luckasRanarison/tailwind-tools.nvim",
  --   ft = {
  --     "html",
  --     "css",
  --     "scss",
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --   },
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   opts = {},
  -- },

  -- Terminal toggle
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    keys = {
      { "<leader>tt", desc = "Terminal (horizontal)" },
      { "<leader>tv", desc = "Terminal (vertical)" },
      { "<C-`>", desc = "Terminal (float)" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = {
        border = "rounded",
      },
      shade_terminals = true,
      shading_factor = 2,
    },
  },

  -- Which-key popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300,
      win = {
        border = "rounded",
      },
      layout = {
        spacing = 3,
      },
    },
  },

  -- Jump/search with s
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/persistence.nvim",
      { "nhattVim/alpha-ascii.nvim", opts = { header = "random" } },
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local telescope_themes = require("telescope.themes")
      local raw_alpha_draw = alpha.draw

      alpha.draw = function(...)
        local state = alpha.state
        if type(state) == "table" and state.winid and not vim.api.nvim_win_is_valid(state.winid) then
          state.winid = nil
        end
        return raw_alpha_draw(...)
      end

      local function tb(name, opts)
        vim.schedule(function()
          local ok, builtin = pcall(require, "telescope.builtin")
          if not ok or type(builtin[name]) ~= "function" then
            vim.notify("Telescope is unavailable", vim.log.levels.WARN)
            return
          end
          local anchor_win = vim.api.nvim_get_current_win()
          local anchor_w = vim.api.nvim_win_get_width(anchor_win)
          local anchor_h = vim.api.nvim_win_get_height(anchor_win)
          local clean_dropdown = telescope_themes.get_dropdown({
            previewer = false,
            layout_strategy = "center",
            layout_config = {
              width = math.max(52, math.floor(anchor_w * 0.82)),
              height = math.max(12, math.floor(anchor_h * 0.58)),
            },
          })
          local final_opts = vim.tbl_deep_extend("force", clean_dropdown, opts or {})
          builtin[name](final_opts)
        end)
      end

      pcall(vim.api.nvim_del_user_command, "AlphaFindFiles")
      pcall(vim.api.nvim_del_user_command, "AlphaRecentFiles")
      pcall(vim.api.nvim_del_user_command, "AlphaLiveGrep")
      pcall(vim.api.nvim_del_user_command, "AlphaFindDirs")
      vim.api.nvim_create_user_command("AlphaFindFiles", function()
        tb("find_files")
      end, {})
      vim.api.nvim_create_user_command("AlphaRecentFiles", function()
        tb("oldfiles")
      end, {})
      vim.api.nvim_create_user_command("AlphaLiveGrep", function()
        tb("live_grep")
      end, {})
      vim.api.nvim_create_user_command("AlphaFindDirs", function()
        tb("find_directories")
      end, {})

      local quotes = {
        "What we assembled with trembling hands, rose to question its maker.",
        "The interface is quiet. The ideas are not.",
        "Precision over noise. Focus over frenzy.",
        "Write less. Mean more.",
        "Tools fade. Craft remains.",
        "A sharp editor reveals dull thinking.",
        "Small feedback loops build large systems.",
        "Clean edges, ruthless intent.",
        "Every keystroke is a design decision.",
        "Speed is earned by clarity.",
      }
      math.randomseed(os.time() + (vim.loop and math.floor(vim.loop.hrtime() % 1000000) or 0))
      local quote = quotes[math.random(1, #quotes)]

      local message = {
        type = "text",
        val = quote,
        opts = { hl = "Comment", position = "center" },
      }

      local function pad_right(text, width)
        local len = vim.fn.strdisplaywidth(text)
        if len >= width then
          return text
        end
        return text .. string.rep(" ", width - len)
      end

      local function grid_line(left, right)
        local l = pad_right(left, 22)
        local r = pad_right(right, 22)
        return " " .. l .. " | " .. r
      end

      local command_grid = {
        type = "group",
        val = {
          { type = "text", val = " ┌────────────────────────┬────────────────────────┐", opts = { position = "center", hl = "Comment" } },
          { type = "text", val = grid_line("[f] Find Files", "[r] Recent Files"), opts = { position = "center", hl = "Comment" } },
          { type = "text", val = grid_line("[g] Find Text", "[d] Find Directory"), opts = { position = "center", hl = "Comment" } },
          { type = "text", val = grid_line("[c] Config", "[n] New File"), opts = { position = "center", hl = "Comment" } },
          { type = "text", val = grid_line("[s] Restore Session", "[l] Lazy"), opts = { position = "center", hl = "Comment" } },
          { type = "text", val = grid_line("[q] Quit", ""), opts = { position = "center", hl = "Comment" } },
          { type = "text", val = " └────────────────────────┴────────────────────────┘", opts = { position = "center", hl = "Comment" } },
        },
        opts = { spacing = 0 },
      }

      local function footer()
        local ok_lazy, lazy = pcall(require, "lazy")
        local stats = ok_lazy and type(lazy.stats) == "function" and lazy.stats() or {}
        local version = vim.version()
        return string.format(
          "%s  •  %d plugins  •  %.2fms  •  v%d.%d.%d",
          os.date("%d-%m-%Y  %H:%M"),
          stats.count or 0,
          tonumber(stats.startuptime) or 0,
          version.major,
          version.minor,
          version.patch
        )
      end

      local function has_alpha_window()
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          if vim.api.nvim_win_is_valid(win) then
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "alpha" then
              return true
            end
          end
        end
        return false
      end

      local function safe_alpha_redraw()
        if not has_alpha_window() then
          return
        end
        vim.schedule(function()
          if has_alpha_window() then
            pcall(vim.cmd.AlphaRedraw)
          end
        end)
      end

      local function clear_alpha_state(win, buf)
        local ok_alpha, alpha_mod = pcall(require, "alpha")
        if not ok_alpha or type(alpha_mod) ~= "table" then
          return
        end
        local state = alpha_mod.state
        if type(state) ~= "table" then
          return
        end
        if win and state.winid == win then
          state.winid = nil
        end
        if buf and (state.bufnr == buf or state.buffer == buf) then
          state.bufnr = nil
          state.buffer = nil
        end
      end

      local function refresh_footer(redraw)
        if vim.o.lines < 24 then
          return
        end
        dashboard.section.footer.val = footer()
        if redraw and vim.bo[vim.api.nvim_get_current_buf()].filetype == "alpha" then
          safe_alpha_redraw()
        end
      end

      local screen_lines = vim.o.lines
      local show_message = screen_lines >= 20
      local show_footer = screen_lines >= 24

      dashboard.section.header.opts.hl = "Comment"
      dashboard.section.footer.val = ""
      dashboard.section.footer.opts.hl = "Comment"

      local layout = {
        { type = "padding", val = 0 },
        dashboard.section.header,
        { type = "padding", val = 0 },
      }
      if show_message then
        layout[#layout + 1] = { type = "padding", val = 2 }
        layout[#layout + 1] = message
        layout[#layout + 1] = { type = "padding", val = 0 }
      end
      layout[#layout + 1] = command_grid
      if show_footer then
        layout[#layout + 1] = { type = "padding", val = 0 }
        layout[#layout + 1] = dashboard.section.footer
      end
      dashboard.config.layout = layout

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
      refresh_footer(false)

      local ok_ascii, ascii = pcall(require, "alpha_ascii")
      if ok_ascii and ascii and type(ascii.setup) == "function" then
        ascii.setup({ header = "random" })
      end

      local function constrain_header_size()
        local header = dashboard.config.layout[2]
        if type(header) ~= "table" or type(header.val) ~= "table" then
          return
        end
        header.opts = header.opts or {}
        header.opts.position = "center"
        header.opts.hl = "Comment"
        local max_width = math.max(56, math.floor(vim.o.columns * 0.68))
        local max_lines = math.max(4, vim.o.lines - (show_message and 15 or 13))
        local clipped = {}
        for _, line in ipairs(header.val) do
          clipped[#clipped + 1] = vim.fn.strcharpart(line, 0, max_width)
        end
        if #clipped > max_lines then
          local start_idx = math.floor((#clipped - max_lines) / 2) + 1
          local limited = {}
          for i = start_idx, math.min(#clipped, start_idx + max_lines - 1) do
            limited[#limited + 1] = clipped[i]
          end
          clipped = limited
        end
        header.val = clipped
      end
      constrain_header_size()
      safe_alpha_redraw()

      local function map_dashboard_keys(bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
        vim.keymap.set("n", "f", function() tb("find_files") end, opts)
        vim.keymap.set("n", "r", function() tb("oldfiles", { previewer = false, prompt_title = "Recent Files" }) end, opts)
        vim.keymap.set("n", "g", function() tb("live_grep") end, opts)
        vim.keymap.set("n", "d", function() tb("find_directories", { prompt_title = "Directories" }) end, opts)
        vim.keymap.set("n", "c", "<cmd>cd ~/.config/nvim | e $MYVIMRC | NvimTreeRefresh<CR>", opts)
        vim.keymap.set("n", "s", "<cmd>lua if _G.restore_session_with_plugins then _G.restore_session_with_plugins() else require('persistence').load() end<CR>", opts)
        vim.keymap.set("n", "n", "<cmd>ene <BAR> startinsert<CR>", opts)
        vim.keymap.set("n", "l", "<cmd>Lazy<CR>", opts)
        vim.keymap.set("n", "q", "<cmd>quit<CR>", opts)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.opt_local.fillchars = { eob = " " }
          constrain_header_size()
          refresh_footer(true)
          local bufnr = vim.api.nvim_get_current_buf()
          if vim.bo[bufnr].filetype == "alpha" then
            map_dashboard_keys(bufnr)
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = { "LazyDone", "VeryLazy" },
        callback = function()
          refresh_footer(true)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function(event)
          vim.opt_local.foldenable = false
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          refresh_footer(true)
          map_dashboard_keys(event.buf)
        end,
      })

      local function is_real_file_buffer(bufnr)
        if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
          return false
        end
        local ft = vim.bo[bufnr].filetype
        local bt = vim.bo[bufnr].buftype
        local name = vim.api.nvim_buf_get_name(bufnr)
        if ft == "alpha" or ft == "NvimTree" or ft == "aerial" then
          return false
        end
        return bt == "" and name ~= "" and not name:match("^term://")
      end

      vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("AlphaCloseOnRealFile", { clear = true }),
        callback = function(args)
          if not is_real_file_buffer(args.buf) then
            return
          end
          local current_win = vim.api.nvim_get_current_win()
          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if win ~= current_win and vim.api.nvim_win_is_valid(win) then
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "alpha" then
                clear_alpha_state(win, buf)
                pcall(vim.api.nvim_win_close, win, true)
              end
            end
          end
        end,
      })

      vim.api.nvim_create_autocmd("WinClosed", {
        group = vim.api.nvim_create_augroup("AlphaStateCleanup", { clear = true }),
        callback = function(event)
          local winid = tonumber(event.match)
          if not winid then
            return
          end
          local ok, buf = pcall(vim.api.nvim_win_get_buf, winid)
          if ok and vim.bo[buf].filetype == "alpha" then
            clear_alpha_state(winid, buf)
          end
        end,
      })

      if vim.bo.filetype == "alpha" then
        map_dashboard_keys(vim.api.nvim_get_current_buf())
      end
    end,
  },

  -- Auto save/restore sessions per project
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~", "~/", "/", "" },
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_create_enabled = true,
      session_lens = {
        load_on_setup = true,
        theme_conf = { border = "rounded" },
        previewer = false,
      },
    },
    keys = {
      { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save Session" },
      { "<leader>sl", "<cmd>SessionRestore<cr>", desc = "Restore Session" },
      { "<leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete Session" },
      { "<leader>sf", "<cmd>SessionSearch<cr>", desc = "Search Sessions" },
    },
  },


}
