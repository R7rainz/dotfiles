vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Neovide Configuration
if vim.g.neovide then
  -- Font settings
  vim.o.guifont = "FantasqueSansM Nerd Font Mono:h15"

  -- Cursor animations
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_length = 0.8
  vim.g.neovide_cursor_vfx_particle_density = 15.0
  vim.g.neovide_cursor_vfx_opacity = 300.0
  vim.g.neovide_cursor_vfx_speed = 50.0
  vim.g.neovide_cursor_animation_length = 0.2
  vim.g.neovide_cursor_trail_size = 1
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125

  -- Scroll animation
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_scroll_animation_far_lines = 1

  -- Window settings
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  -- Refresh rate
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5

  -- Performance
  vim.g.neovide_no_idle = true
  vim.g.neovide_confirm_quit = true

  -- Padding (comfortable spacing around the editor)
  vim.g.neovide_padding_top = 10

  -- Fullscreen
  vim.g.neovide_fullscreen = false
  vim.g.neovide_remember_window_size = true

  -- Input
  vim.g.neovide_input_macos_alt_is_meta = true

  -- Scale factor (zoom)
  vim.g.neovide_scale_factor = 1.0

  -- Keybindings for scaling
  vim.keymap.set("n", "<C-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end, { desc = "Increase scale" })

  vim.keymap.set("n", "<C-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
  end, { desc = "Decrease scale" })

  vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Reset scale" })

  -- Fullscreen toggle
  vim.keymap.set("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle fullscreen" })

  -- Delete previous word with Ctrl+Backspace (like browsers/editors)
  vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })
  vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Delete previous word (fallback)" })
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
    config = function()
      local alpha = require "alpha"
      local dashboard = require "alpha.themes.dashboard"

      -- Set header with RAINZ ASCII art
      dashboard.section.header.val = {
        "",
        "",
        "  ██████╗  █████╗ ██╗███╗   ██╗███████╗",
        "  ██╔══██╗██╔══██╗██║████╗  ██║╚══███╔╝",
        "  ██████╔╝███████║██║██╔██╗ ██║  ███╔╝ ",
        "  ██╔══██╗██╔══██║██║██║╚██╗██║ ███╔╝  ",
        "  ██║  ██║██║  ██║██║██║ ╚████║███████╗",
        "  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝",
        "",
        "         Welcome back SIUUUUUUUU! 🚀",
        "",
      }

      -- Set menu with better formatting
      dashboard.section.buttons.val = {
        dashboard.button("f", "   Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("n", "   New File", "<cmd>ene <BAR> startinsert<CR>"),
        dashboard.button("r", "   Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", "   Find Text", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("p", "   Open Project", "<cmd>lua require('alpha.custom').open_project()<CR>"),
        dashboard.button("c", "   Configuration", "<cmd>cd ~/.config/nvim | e init.lua<CR>"),
        dashboard.button("q", "   Quit", "<cmd>qa<CR>"),
      }

      -- Set footer
      local function footer()
        local total_plugins = #vim.tbl_keys(require("lazy").plugins())
        local datetime = os.date "%d-%m-%Y"
        local version = vim.version()
        local nvim_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
        return string.format("  %s    %s    %d plugins", datetime, nvim_version, total_plugins)
      end

      dashboard.section.footer.val = footer()

      -- Styling with better highlights
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- Add spacing between buttons
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl_shortcut = "AlphaShortcut"
        button.opts.hl = "AlphaButtons"
        button.opts.width = 40
      end

      -- Layout with better spacing
      dashboard.config.layout = {
        { type = "padding", val = 4 },
        dashboard.section.header,
        { type = "padding", val = 3 },
        dashboard.section.buttons,
        { type = "padding", val = 2 },
        dashboard.section.footer,
      }

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.config)

      -- Define highlight groups with better colors
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#89b4fa", bold = true })
          vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#cdd6f4" })
          vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#f38ba8", bold = true })
          vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#6c7086", italic = true })
        end,
      })

      -- Custom module for project opening with telescope directory picker
      local custom_module = {}

      function custom_module.open_project()
        -- Use telescope to browse and select directories
        local telescope_builtin = require "telescope.builtin"
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        -- Create a custom picker for directories
        require("telescope.pickers")
          .new({}, {
            prompt_title = "Select Project Folder",
            finder = require("telescope.finders").new_oneshot_job(
              vim.tbl_flatten {
                "find",
                vim.fn.expand "~",
                "-maxdepth",
                "4",
                "-type",
                "d",
                "-not",
                "-path",
                "*/.*",
                "-not",
                "-path",
                "*/node_modules/*",
                "-not",
                "-path",
                "*/.git/*",
              },
              {}
            ),
            sorter = require("telescope.config").values.generic_sorter {},
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local dir = selection[1]
                  vim.cmd("cd " .. vim.fn.fnameescape(dir))
                  vim.notify("📁 Opened: " .. dir, vim.log.levels.INFO)

                  -- Load Oil plugin and open the directory
                  vim.schedule(function()
                    -- Ensure Oil is loaded
                    require("lazy").load { plugins = { "oil.nvim" } }
                    vim.defer_fn(function()
                      require("oil").open(dir)
                    end, 100)
                  end)
                end
              end)
              return true
            end,
          })
          :find()
      end

      package.loaded["alpha.custom"] = custom_module

      vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]

      -- Auto open alpha when no files are specified
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 and vim.fn.line2byte "$" == -1 then
            require("alpha").start(true)
          end
        end,
      })
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
