return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },

    -- Disable legacy + Lazy auto-open behavior
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,

    keys = {
      { "<leader>e", "<cmd>Neotree float toggle<cr>", desc = "NeoTree (float)" },
      { "<leader><tab>", "<cmd>Neotree toggle<cr>", desc = "NeoTree (toggle)" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "NeoTree (focus)" },
    },

    config = function()
      require("neo-tree").setup({

        ----------------------------------------------------------------
        -- 🚫 Startup behavior
        ----------------------------------------------------------------
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,

        close_if_last_window = true,
        popup_border_style = "rounded",
        sort_case_insensitive = true,

        enable_git_status = true,
        enable_diagnostics = true,

        ----------------------------------------------------------------
        -- 🎨 Component styles (FIXED INDENTATION)
        ----------------------------------------------------------------
        default_component_configs = {

          container = {
            enable_character_fade = false,
          },

          -- 🌿 PERFECTLY ALIGNED indentation (NO MARKERS)
          indent = {
            indent_size = 2,
            padding = 0,

            -- 🔥 CRITICAL FIX
            with_markers = false,

            -- hierarchy via expanders only
            with_expanders = true,

            -- modern chevrons
            expander_collapsed = "›",
            expander_expanded = "⌄",

            expander_highlight = "NeoTreeExpander",
          },

          -- 📁 Clean Nerd Font icons
          icon = {
            folder_closed = "󰉋",
            folder_open = "󰝰",
            folder_empty = "󰉖",
            folder_empty_open = "󰉖",
            default = "󰈔",
            highlight = "NeoTreeFileIcon",
          },

          modified = {
            symbol = "●",
            highlight = "NeoTreeModified",
          },

          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },

          -- Minimal git symbols
          git_status = {
            symbols = {
              added = "+",
              modified = "~",
              deleted = "-",
              renamed = ">",
              untracked = "?",
              ignored = "",
              unstaged = "!",
              staged = "*",
              conflict = "!",
            },
          },
        },

        ----------------------------------------------------------------
        -- 🪟 Window
        ----------------------------------------------------------------
        window = {
          position = "left",
          width = 34,

          mappings = {
            ["<cr>"] = "open",
            ["l"] = "open",
            ["h"] = "close_node",
            ["<esc>"] = "cancel",

            ["P"] = { "toggle_preview", config = { use_float = true } },

            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",

            ["a"] = "add",
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",

            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",

            ["R"] = "refresh",
            ["q"] = "close_window",
            ["?"] = "show_help",
          },
        },

        ----------------------------------------------------------------
        -- 📁 Filesystem
        ----------------------------------------------------------------
        filesystem = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },

          group_empty_dirs = true,
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = true,

          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },

          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
            },
          },
        },

        ----------------------------------------------------------------
        -- 📦 Buffers
        ----------------------------------------------------------------
        buffers = {
          follow_current_file = { enabled = true },
          group_empty_dirs = true,
        },

        ----------------------------------------------------------------
        -- 🌱 Git status
        ----------------------------------------------------------------
        git_status = {
          window = {
            position = "float",
          },
        },
      })
    end,
  },
}
