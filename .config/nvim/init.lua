vim.g.mapleader = " "

-- Neovide Configuration
if vim.g.neovide then
  -- JetBrains Mono font
  -- vim.o.guifont = "DankMono Nerd Font:h15:b"
  vim.o.guifont = "Victor Mono:h15"

  -- Enable italic support in Neovide
  vim.opt.linespace = 0

  -- Cursor animations
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_length = 1.2
  vim.g.neovide_cursor_vfx_particle_density = 25.0
  vim.g.neovide_cursor_vfx_opacity = 400.0
  vim.g.neovide_cursor_vfx_speed = 60.0
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125

  -- Scroll animation
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_scroll_animation_far_lines = 1

  -- Window settings
  vim.g.neovide_opacity = 0.8
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
  vim.g.neovide_padding_top = 7

  -- Fullscreen
  vim.g.neovide_fullscreen = false
  vim.g.neovide_remember_window_size = true

  -- macOS-style Alt behavior (safe on other OSes too)
  vim.g.neovide_input_macos_alt_is_meta = true

  -- Scale factor (zoom)
  vim.g.neovide_scale_factor = 0.87

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

  -- Delete previous word with Ctrl+Backspace (browser/editor style)
  vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })
  vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Delete previous word (fallback)" })
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
