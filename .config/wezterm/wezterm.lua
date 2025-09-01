-- ~/.config/wezterm/wezterm.lua
-- 🖤 Clean WezTerm Configuration - Pure Black Background

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
config.animation_fps = 60

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
	foreground = "#e0e0e0",
	background = "#000000",
	cursor_bg = "#e0e0e0",
	cursor_fg = "#000000",
	cursor_border = "#e0e0e0",
	selection_fg = "#000000",
	selection_bg = "#4a4a4a",
	scrollbar_thumb = "#2a2a2a",
	split = "#2a2a2a",

	-- Tab bar colors
	tab_bar = {
		background = "#000000",
		active_tab = {
			bg_color = "#4a4a4a",
			fg_color = "#e0e0e0",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#000000",
			fg_color = "#6a6a6a",
		},
		inactive_tab_hover = {
			bg_color = "#2a2a2a",
			fg_color = "#e0e0e0",
		},
	},

	-- Dark ANSI colors with warm accent colors
	ansi = {
		"#2a2a2a", -- black
		"#ff6b6b", -- red (softer coral)
		"#6bff6b", -- green (softer lime)
		"#ffdb6b", -- yellow (warm gold)
		"#6b6bff", -- blue (softer purple-blue)
		"#db6bff", -- magenta (softer purple)
		"#6bffdb", -- cyan (softer teal)
		"#e0e0e0", -- white
	},
	brights = {
		"#4a4a4a", -- bright black
		"#ff8b8b", -- bright red
		"#8bff8b", -- bright green
		"#ffeb8b", -- bright yellow
		"#8b8bff", -- bright blue
		"#eb8bff", -- bright magenta
		"#8bffeb", -- bright cyan
		"#ffffff", -- bright white
	},
	indexed = {
		[17] = "#ff6b6b",
	},
}

-- 🎪 TAB BAR CONFIGURATION
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32

-- 🖱️ MOUSE SUPPORT
config.mouse_bindings = {
	-- Right click paste
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	-- Triple click selects line
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("Line"),
	},
	-- Double click selects word
	{
		event = { Down = { streak = 2, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("Word"),
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
	{ key = "Enter", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "z", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },

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
config.check_for_updates = false
config.audible_bell = "Disabled"
config.scrollback_lines = 10000
config.enable_scroll_bar = false

-- 📏 WINDOW SIZE
config.initial_cols = 120
config.initial_rows = 30

-- Remove background effects
config.window_background_gradient = nil

return config
