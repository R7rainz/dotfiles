local wezterm = require("wezterm")
local config = {}

-- THEME (gruvbox material feel)
config.color_scheme = "Gruvbox Material (Gogh)"

-- FORCE PURE BLACK BACKGROUND
config.colors = {
	background = "#000000",
}

-- PERFORMANCE (smooth but safe)
config.front_end = "WebGpu"
config.max_fps = 120
config.animation_fps = 60

-- THEME (gruvbox material vibe)
config.color_scheme = "Gruvbox Material (Gogh)"

-- FORCE TRUE BLACK BASE
config.colors = {
	background = "#000000",
}

-- WINDOW (no UI at all)
config.window_decorations = "NONE"
config.enable_tab_bar = false

-- BACKGROUND IMAGE (subtle, not distracting)
config.window_background_image = "/home/rainz/Pictures/Wallpapers/gruvbox-3.jpg"

config.window_background_image_hsb = {
	brightness = 0.05, -- very subtle
	hue = 1.0,
	saturation = 0.85,
}

-- KEEP IMAGE IN CONTROL (no washed transparency)
config.window_background_opacity = 1.0

-- FONT (clean + fallback)
config.font = wezterm.font_with_fallback({
	"JetBrains Mono Nerd Font",
	"FantasqueSansM Nerd Font",
	"Noto Color Emoji",
})
config.font_size = 15
config.line_height = 1.0

-- CURSOR (clean + non-distracting)
config.default_cursor_style = "SteadyBar"
config.cursor_blink_rate = 0

-- SCROLLBACK
config.scrollback_lines = 4000

-- WINDOW BEHAVIOR
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 6,
	right = 6,
	top = 4,
	bottom = 4,
}

-- KEYBINDS (minimal + useful)
config.keys = {
	-- fullscreen
	{
		key = "q",
		mods = "CTRL",
		action = wezterm.action.ToggleFullScreen,
	},

	-- clear scrollback
	{
		key = "'",
		mods = "CTRL",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
}

-- CTRL + click links
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
