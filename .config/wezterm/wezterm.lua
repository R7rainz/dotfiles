local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 🎨 FONT CONFIGURATION - Multiple Fallbacks
config.font = wezterm.font_with_fallback({
	{ family = "DankMono Nerd Font", weight = "Regular" },
	{ family = "JetBrains Mono Nerd Font", weight = "Regular" },
	{ family = "Cascadia Code NF", weight = "Regular" },
	{ family = "FiraCode Nerd Font", weight = "Regular" },
	{ family = "Droid Sans Mono Nerd Font", weight = "Regular" },
})
config.font_size = 12.0
config.line_height = 1.2
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- Font rules for different styles
config.font_rules = {
	{
		intensity = "Bold",
		font = wezterm.font("DankMono Nerd Font", { weight = "Bold" }),
	},
	{
		italic = true,
		font = wezterm.font("DankMono Nerd Font", { weight = "Regular", style = "Italic" }),
	},
}

-- 🚀 PERFORMANCE
config.max_fps = 120
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.enable_wayland = true
config.animation_fps = 120

-- 🖼️ WINDOW CONFIGURATION - NO PADDING, NO TITLE BAR
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_background_opacity = 1.0
config.text_background_opacity = 1.0
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = true

-- 🎯 CURSOR CONFIGURATION - Kitty-like
config.default_cursor_style = "SteadyUnderline"
config.cursor_thickness = 2.0
config.animation_fps = 60
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"

config.colors = {
	-- The default text color
	foreground = "#f0f0f0",
	-- The default background color
	background = "#0a0a0a",

	-- Overrides the cursor color
	cursor_bg = "#ff6b6b",
	cursor_fg = "#0a0a0a",
	cursor_border = "#ff6b6b",

	-- Overrides the selection colors
	selection_fg = "#ffffff",
	selection_bg = "#404040",

	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
	scrollbar_thumb = "#666666",

	-- The color of the split lines between panes
	split = "#333333",

	ansi = {
		"#1a1a1a", -- black (darker for contrast)
		"#ff4757", -- red (vibrant red)
		"#2ed573", -- green (mid vibrant green)
		"#FFD700", -- gold
		"#ff6348", -- blue replacement (coral-red)
		"#ff3838", -- magenta (bright red-pink)
		"#00d2d3", -- cyan (vibrant cyan - you mentioned cyan alone is fine)
		"#f1f2f6", -- white (soft white)
	},

	brights = {
		"#2f3542", -- bright black (gray)
		"#ff6b7a", -- bright red
		"#7bed9f", -- bright green
		"#FFD700", -- bright yellow
		"#ff7675", -- bright blue replacement (salmon)
		"#fd79a8", -- bright magenta (pink)
		"#74b9ff", -- bright cyan (keeping this vibrant)
		"#ffffff", -- bright white (pure white)
	},

	-- Colors for copy_mode and quick_select
	copy_mode_active_highlight_bg = { Color = "#ff6b6b" },
	copy_mode_active_highlight_fg = { Color = "#0a0a0a" },
	copy_mode_inactive_highlight_bg = { Color = "#404040" },
	copy_mode_inactive_highlight_fg = { Color = "#f0f0f0" },

	quick_select_label_bg = { Color = "#ffa502" },
	quick_select_label_fg = { Color = "#0a0a0a" },
	quick_select_match_bg = { Color = "#ff4757" },
	quick_select_match_fg = { Color = "#ffffff" },

	-- Visual bell
	visual_bell = "#ff6b6b",

	tab_bar = {
		background = "#0f0f23", -- Deep dark blue/purple
		active_tab = {
			bg_color = "#6c5ce7", -- Purple accent
			fg_color = "#ffffff",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#2d3748", -- Dark gray-blue
			fg_color = "#a0aec0", -- Light gray
		},
		inactive_tab_hover = {
			bg_color = "#4a5568", -- Lighter gray-blue
			fg_color = "#e2e8f0", -- Almost white
		},
		new_tab = {
			bg_color = "#2d3748",
			fg_color = "#a0aec0",
		},
		new_tab_hover = {
			bg_color = "#6c5ce7",
			fg_color = "#ffffff",
		},
	},
}
-- ⌨️ KEY BINDINGS
config.keys = {
	-- Clipboard
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- Font size
	{ key = "=", mods = "CTRL|SHIFT", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL|SHIFT", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL|SHIFT", action = wezterm.action.ResetFontSize },

	-- Tab management
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

	-- Tab navigation by number
	{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },

	-- Pane management
	{ key = "Enter", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "/", mods = "CTRL", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Try with just CTRL
	{ key = "z", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },

	-- Navigate between panes using arrow keys
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

	-- Search
	{ key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },

	-- Quick select
	{ key = " ", mods = "CTRL|SHIFT", action = wezterm.action.QuickSelect },

	-- Reload config
	{ key = "r", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },
}

-- 🔗 URL DETECTION
config.hyperlink_rules = {
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},
}

-- 🐚 SHELL CONFIGURATION
config.set_environment_variables = {
	TERM = "wezterm",
	COLORTERM = "truecolor",
}
config.default_prog = { "/bin/fish", "-l" }

-- 💡 SETTINGS
config.automatically_reload_config = true
config.check_for_updates = true
config.audible_bell = "SystemBeep"
config.scrollback_lines = 10000
config.enable_scroll_bar = false

-- 📏 WINDOW SIZE
config.initial_cols = 120
config.initial_rows = 30

-- Remove background effects
config.window_background_gradient = nil

-- 🖼️ BACKGROUND IMAGE PATH
local bg_image = os.getenv("HOME") .. "/Dotfiles/.config/wezterm/assets/bg-blurred-darker.png"

-- 🖼️ SIMPLE IMAGE BACKGROUND (Current WezTerm syntax)
config.background = {
	{
		source = { File = bg_image },
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		width = "Cover",
		height = "Cover",
		vertical_align = "Middle",
		horizontal_align = "Center",
	},
}

-- 🎆 ADDITIONAL VISUAL ENHANCEMENTS
config.bold_brightens_ansi_colors = true
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

config.macos_window_background_blur = 20

return config
