return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    -- Disable auto-opening when vim starts with a directory
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      -- Disable LazyVim's auto-open behavior for neo-tree
      vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("neotree_disable_auto_open", { clear = true }),
        callback = function()
          -- Prevent any auto-opening of neo-tree
          pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_neo_tree")
        end,
      })
    end,
    keys = {
      { "<leader><tab>", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
      { "<leader>e", "<cmd>Neotree float<cr>", desc = "NeoTree (floating)" },
    },
    config = function()
      require("neo-tree").setup({
        -- Prevent auto-opening on startup
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,

        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = true,

        default_component_configs = {
          container = {
            enable_character_fade = false,
          },

          -- ✅ indentation WITHOUT lines, GOOD tail arrows
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true, -- no │ ├ └ lines
            indent_marker = "",
            last_indent_marker = "",
            with_expanders = true,

            -- 🔥 GOOD tail arrows
            expander_collapsed = "",
            expander_expanded = "",

            expander_highlight = "NeoTreeExpander",
          },

          -- 📁 RESTORED Nerd Font icons (these worked for you)
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            folder_empty_open = "󰜌",
            default = "",
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

          -- ⚠ keep git symbols minimal to avoid boxes
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

        window = {
          position = "left",
          width = 34,
          mappings = {
            ["<cr>"] = "open",
            ["l"] = "open",
            ["h"] = "close_node",
            ["<esc>"] = "cancel",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
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

        filesystem = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          hijack_netrw_behavior = "open_default",

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

        buffers = {
          follow_current_file = {
            enabled = true,
          },
          group_empty_dirs = true,
        },

        git_status = {
          window = {
            position = "float",
          },
        },
      })
    end,
  },
}
