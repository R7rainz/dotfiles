vim.g.mapleader = " "

-- Minimize command line height to remove extra space at the bottom
vim.opt.cmdheight = 0

-- ═══════════════════════════════════════════════════════════════════════════
--  NEOVIDE CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════

if vim.g.neovide then
    -- ─────────────────────────────────────────────────────────────────────────
    --  Typography & Rendering
    -- ─────────────────────────────────────────────────────────────────────────

    -- vim.o.guifont = "SF Mono:h15"
    vim.o.guifont = "JetBrainsMono Nerd Font:h15"

    vim.opt.linespace = 1 -- Slightly more breathing room between lines

    -- ─────────────────────────────────────────────────────────────────────────
    --  Cursor Effects & Animation
    -- ─────────────────────────────────────────────────────────────────────────

    vim.g.neovide_cursor_vfx_mode = "pixiedust" -- Options: ripple, torpedo, pixiedust, sonicboom, railgun, wireframe
    vim.g.neovide_cursor_vfx_particle_lifetime = 0.7
    vim.g.neovide_cursor_vfx_particle_density = 40.0
    vim.g.neovide_cursor_vfx_opacity = 100.0
    vim.g.neovide_cursor_vfx_particle_speed = 10.0

    vim.g.neovide_cursor_animation_length = 0.2 -- Snappier feel
    vim.g.neovide_cursor_trail_size = 1.0
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_unfocused_outline_width = 0.125

    -- ─────────────────────────────────────────────────────────────────────────
    --  Scroll Dynamics
    -- ─────────────────────────────────────────────────────────────────────────

    vim.g.neovide_scroll_animation_length = 0.25
    vim.g.neovide_scroll_animation_far_lines = 1
    vim.g.neovide_hide_mouse_when_typing = true

    -- ─────────────────────────────────────────────────────────────────────────
    --  Window & Transparency
    -- ─────────────────────────────────────────────────────────────────────────

    -- Light macOS-style glass effect
    vim.g.neovide_opacity = 0.95
    vim.g.neovide_window_blurred = true

    vim.g.neovide_floating_blur_amount_x = 3.0
    vim.g.neovide_floating_blur_amount_y = 3.0
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5

    -- Dynamic background (adapts to your colorscheme)
    -- vim.g.neovide_background_color = "#000000" -- Match your black theme

    -- ─────────────────────────────────────────────────────────────────────────
    --  Performance & Refresh
    -- ─────────────────────────────────────────────────────────────────────────

    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_no_idle = true
    vim.g.neovide_confirm_quit = true

    -- ─────────────────────────────────────────────────────────────────────────
    --  Layout & Spacing
    -- ─────────────────────────────────────────────────────────────────────────

    vim.g.neovide_padding_top = 12
    vim.g.neovide_padding_bottom = 12
    vim.g.neovide_padding_right = 12
    vim.g.neovide_padding_left = 12

    -- ─────────────────────────────────────────────────────────────────────────
    --  Window Behavior
    -- ─────────────────────────────────────────────────────────────────────────

    vim.g.neovide_fullscreen = false
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_input_macos_alt_is_meta = true

    -- ─────────────────────────────────────────────────────────────────────────
    --  Zoom & Scale
    -- ─────────────────────────────────────────────────────────────────────────

    vim.g.neovide_scale_factor = 1.0

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end

    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.1)
    end, { desc = "󰁌 Increase scale" })

    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.1)
    end, { desc = "󰁍 Decrease scale" })

    vim.keymap.set("n", "<C-0>", function()
        vim.g.neovide_scale_factor = 1.0
    end, { desc = "󰁎 Reset scale" })

    -- ─────────────────────────────────────────────────────────────────────────
    --  Keybindings
    -- ─────────────────────────────────────────────────────────────────────────

    -- Fullscreen
    vim.keymap.set("n", "<F11>", function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end, { desc = "󰊓 Toggle fullscreen" })

    -- Editor-style word deletion
    vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })
    vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Delete previous word (fallback)" })

    -- Paste from system clipboard (Cmd+V / Ctrl+V)
    vim.keymap.set({ "n", "v", "i", "c" }, "<D-v>", function()
        vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
    end, { desc = "Paste from clipboard" })

    -- Copy to system clipboard (Cmd+C / Ctrl+C)
    vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy to clipboard" })

    -- ─────────────────────────────────────────────────────────────────────────
    --  Optional: Cursor Style Variants
    -- ─────────────────────────────────────────────────────────────────────────

    -- Uncomment to try different cursor effects:
    -- vim.g.neovide_cursor_vfx_mode = "railgun"  -- Fast and sleek
    -- vim.g.neovide_cursor_vfx_mode = "torpedo"  -- Smooth trail
    -- vim.g.neovide_cursor_vfx_mode = "sonicboom"  -- Energetic pulse
end

-- ═══════════════════════════════════════════════════════════════════════════
--  BOOTSTRAP
-- ═══════════════════════════════════════════════════════════════════════════

require("config.lazy")
