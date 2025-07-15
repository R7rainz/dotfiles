return {
  -- Package info for package.json
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {},
    event = "BufRead package.json",
  },

  -- TypeScript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = {},
        tsserver_path = nil,
        tsserver_plugins = {},
        tsserver_max_memory = "auto",
        tsserver_format_options = {},
        tsserver_file_preferences = {},
        tsserver_locale = "en",
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        code_lens = "off",
        disable_member_code_lens = true,
        jsx_close_tag = {
          enable = false,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
      },
    },
  },

  -- React snippets and tools
  {
    "windwp/nvim-ts-autotag",
    opts = {},
    event = "VeryLazy",
  },

  -- Tailwind CSS colorizer
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  -- Live server for web development
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
  },

  -- Better quickfix window
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            ret = false
          end
          return ret
        end,
      },
      func_map = {
        drop = "o",
        openc = "O",
        split = "<C-s>",
        vsplit = "<C-v>",
        tab = "t",
        tabb = "T",
        tabc = "<C-t>",
        tabdrop = "",
        ptogglemode = "z,",
        pscrollup = "<C-b>",
        pscrolldown = "<C-f>",
        pscrollorig = "zo",
        prevfile = "<C-p>",
        nextfile = "<C-n>",
        prevhist = "<",
        nexthist = ">",
        lastleave = [['"]],
        stoggleup = "<S-Tab>",
        stoggledown = "<Tab>",
        stogglevm = "<Tab>",
        stogglebuf = [['<Tab>"]],
        sclear = "z<Tab>",
        filter = "zn",
        filterr = "zN",
        fzffilter = "zf",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },

  -- REST client
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "http",
    opts = {
      result_split_horizontal = false,
      result_split_in_place = false,
      stay_in_current_window_after_split = false,
      skip_ssl_verification = false,
      encode_url = true,
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        show_url = true,
        show_curl_command = false,
        show_http_info = true,
        show_headers = true,
        show_statistics = false,
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
          end,
        },
      },
      jump_to_request = false,
      env_file = ".env",
      custom_dynamic_variables = {},
      yank_dry_run = true,
      search_back = true,
    },
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run REST request" },
      { "<leader>rl", "<cmd>Rest run last<cr>", desc = "Re-run last REST request" },
      { "<leader>rp", "<cmd>Rest run preview<cr>", desc = "Preview REST request" },
    },
  },

  -- Browser sync
  {
    "ray-x/web-tools.nvim",
    opts = {
      keymaps = {
        rename = nil,
        repeat_rename = ".",
      },
      hurl = {
        show_headers = false,
        floating = false,
        json5 = false,
        formatters = {
          json = { "jq" },
          html = { "prettier", "--parser", "html" },
        },
      },
    },
    keys = {
      { "<leader>wb", "<cmd>BrowserSync<cr>", desc = "Browser Sync" },
      { "<leader>wo", "<cmd>BrowserOpen<cr>", desc = "Browser Open" },
      { "<leader>wr", "<cmd>BrowserRestart<cr>", desc = "Browser Restart" },
    },
  },
}
