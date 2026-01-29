local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 🎨 FONT CONFIGURATION - Multiple Fallbacks
config.font = wezterm.font_with_fallback({
	-- { family = "FanTasqueSansM Nerd Font Mono" },
	{ family = "Victor Mono", weight = "Regular" },
})
config.font_size = 12.5
config.line_height = 1.2
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

-- Font rules for different styles
config.font_rules = {
	{
		intensity = "Bold",
		font = wezterm.font("Victor Mono", { weight = "Bold" }),
	},
	{
		italic = true,
		font = wezterm.font("Victor Mono", { weight = "Regular", style = "Italic" }),
	},
}

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 1,
		right = 1,
		tabs = {
			left = 0,
			right = 2,
		},
	},
	separator = {
		space = 1,
		left_icon = wezterm.nerdfonts.fa_long_arrow_right,
		right_icon = wezterm.nerdfonts.fa_long_arrow_left,
		field_icon = wezterm.nerdfonts.indent_line,
	},
	modules = {
		tabs = {
			active_tab_fg = 4,
			inactive_tab_fg = 6,
			new_tab_fg = 2,
		},
		workspace = {
			enabled = true,
			icon = wezterm.nerdfonts.cod_window,
			color = 8,
		},
		leader = {
			enabled = true,
			icon = wezterm.nerdfonts.oct_rocket,
			color = 2,
		},
		zoom = {
			enabled = false,
			icon = wezterm.nerdfonts.md_fullscreen,
			color = 4,
		},
		pane = {
			enabled = true,
			icon = wezterm.nerdfonts.cod_multiple_windows,
			color = 7,
		},
		username = {
			enabled = true,
			icon = wezterm.nerdfonts.fa_user,
			color = 6,
		},
		hostname = {
			enabled = true,
			icon = wezterm.nerdfonts.cod_server,
			color = 8,
		},
		clock = {
			enabled = true,
			icon = wezterm.nerdfonts.md_calendar_clock,
			format = "%H:%M",
			color = 5,
		},
		cwd = {
			enabled = true,
			icon = wezterm.nerdfonts.oct_file_directory,
			color = 7,
		},
	},
})

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
config.window_background_opacity = 0.8
config.text_background_opacity = 1.0
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.hide_tab_bar_if_only_one_tab = false

config.default_cursor_style = "BlinkingBlock"
config.cursor_thickness = 1.0
config.animation_fps = 60
config.cursor_blink_rate = 700
config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"

-- 🎨 NOCTALIA COLOR SCHEME
config.colors = {
	-- The default text color
	foreground = "#dfe3e7",
	-- The default background color
	background = "#101417",

	-- Overrides the cursor color
	cursor_bg = "#dfe3e7",
	cursor_fg = "#101417",
	cursor_border = "#dfe3e7",

	-- Overrides the selection colors
	selection_fg = "#c1c7ce",
	selection_bg = "#41484d",

	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
	scrollbar_thumb = "#8b9198",

	-- The color of the split lines between panes
	split = "#41484d",

	ansi = {
		"#101417", -- black
		"#ffb4ab", -- red
		"#ccc1e9", -- green
		"#b6c9d8", -- yellow
		"#92cef5", -- blue
		"#ccc1e9", -- magenta
		"#b6c9d8", -- cyan
		"#dfe3e7", -- white
	},

	brights = {
		"#8b9198", -- bright black
		"#ffb4ab", -- bright red
		"#ccc1e9", -- bright green
		"#b6c9d8", -- bright yellow
		"#92cef5", -- bright blue
		"#ccc1e9", -- bright magenta
		"#b6c9d8", -- bright cyan
		"#dfe3e7", -- bright white
	},

	-- Colors for copy_mode and quick_select
	copy_mode_active_highlight_bg = { Color = "#92cef5" },
	copy_mode_active_highlight_fg = { Color = "#101417" },
	copy_mode_inactive_highlight_bg = { Color = "#41484d" },
	copy_mode_inactive_highlight_fg = { Color = "#dfe3e7" },

	quick_select_label_bg = { Color = "#b6c9d8" },
	quick_select_label_fg = { Color = "#101417" },
	quick_select_match_bg = { Color = "#ffb4ab" },
	quick_select_match_fg = { Color = "#101417" },

	-- Visual bell
	visual_bell = "#92cef5",

	tab_bar = {
		background = "#101417",
		active_tab = {
			bg_color = "#92cef5",
			fg_color = "#101417",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#41484d",
			fg_color = "#8b9198",
		},
		inactive_tab_hover = {
			bg_color = "#ccc1e9",
			fg_color = "#101417",
		},
		new_tab = {
			bg_color = "#41484d",
			fg_color = "#8b9198",
		},
		new_tab_hover = {
			bg_color = "#92cef5",
			fg_color = "#101417",
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

-- -- 🖼️ BACKGROUND IMAGE PATH
-- local bg_image = os.getenv("HOME") .. "/Pictures/27230.jpg"
--
-- -- 🖼️ SIMPLE IMAGE BACKGROUND (Current WezTerm syntax)
-- config.background = {
-- 	{
-- 		source = { File = bg_image },
-- 		repeat_x = "NoRepeat",
-- 		repeat_y = "NoRepeat",
-- 		width = "Cover",
-- 		height = "Cover",
-- 		vertical_align = "Middle",
-- 		horizontal_align = "Center",
-- 	},
-- }

-- 🎆 ADDITIONAL VISUAL ENHANCEMENTS
config.bold_brightens_ansi_colors = true
config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

config.macos_window_background_blur = 40
config.warn_about_missing_glyphs = false --Temporarily disable warnings

config.color_scheme = "Noctalia"
return config
