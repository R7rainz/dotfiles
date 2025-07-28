#!/bin/bash

# Simple toggle script for hiding/showing extra modules
CONFIG_DIR="$HOME/.config/waybar"
CONFIG_FILE="$CONFIG_DIR/config"
STATE_FILE="$CONFIG_DIR/.tray_state"

# Check current state
if [[ -f "$STATE_FILE" ]]; then
	STATE=$(cat "$STATE_FILE")
else
	STATE="shown"
	echo "shown" >"$STATE_FILE"
fi

# Your original full config (all modules shown)
FULL_CONFIG='{
  "layer": "top",
  "height": 10,
  "spacing": 0,
  "modules-left": [
    "custom/launcher",
    "custom/separator",
    "cpu",
    "memory",
    "temperature",
    "custom/filler",
    "custom/playerctl",
    "custom/filler",
    "disk",
    "custom/filler",
    "custom/pacman"
  ],
  "modules-center": ["hyprland/workspaces"],
  "modules-right": [
    "battery",
    "custom/dot",
    "backlight",
    "pulseaudio",
    "custom/dot",
    "custom/separator",
    "network",
    "custom/dot",
    "custom/toggle-tray",
    "clock"
  ]
}'

# Minimal config (only essential modules)
MINIMAL_CONFIG='{
  "layer": "top",
  "height": 10,
  "spacing": 0,
  "modules-left": [
    "custom/launcher",
    "custom/separator"
  ],
  "modules-center": ["hyprland/workspaces"],
  "modules-right": [
    "battery",
    "custom/toggle-tray",
    "clock"
  ]
}'

# Add all your existing module configs here (keeping them the same)
MODULE_CONFIGS='
  "custom/playerctl": {
    "format": "[<span foreground='"'"'#46c880'"'"'>  </span> <span>{}</span> ]",
    "return-type": "json",
    "max-length": 55,
    "exec": "playerctl -a metadata --format '"'"'{{\"text\": \"{{playerName}}\"}}'"'"' -F",
    "on-click": "playerctl play-pause",
    "on-click-middle": "playerctl previous",
    "on-click-right": "playerctl next",
    "format-icons": {
      "Playing": "<span foreground='"'"'#46c880'"'"'>  </span>",
      "Paused": "<span foreground='"'"'#cdd6f4'"'"'> 󰏥 </span>"
    }
  },
  "disk": {
    "interval": 1,
    "format": "<span color=\"#68b0d6\"> </span> {}%",
    "on-click": "filelight /",
    "on-click-right": "filelight /home/"
  },
  "hyprland/workspaces": {
    "all-outputs": true,
    "active-only": false,
    "on-click": "activate",
    "format": "{icon}",
    "on-scroll-up": "hyprctl dispatch workspace e+1",
    "on-scroll-down": "hyprctl dispatch workspace e-1",
    "format-icons": {
      "1": "○",
      "2": "○",
      "3": "○",
      "4": "○",
      "5": "○",
      "6": "○",
      "7": "○",
      "8": "○",
      "9": "○",
      "urgent": "",
      "active": "●",
      "default": "○"
    }
  },
  "custom/toggle-tray": {
    "format": "󰍉",
    "tooltip": "Toggle extended tray",
    "on-click": "~/.config/waybar/toggle-tray.sh"
  },
  "custom/filler": {
    "format": " "
  },
  "custom/dot": {
    "format": " "
  },
  "clock": {
    "format": "<b>{:%I:%M %p}</b>",
    "format-alt": "<b>{:%a.%d,%b}</b>",
    "tooltip-format": "<big>{:%B %Y}</big>\\n<tt><small>{calendar}</small></tt>"
  },
  "cpu": {
    "interval": 10,
    "format": " {usage}% ",
    "max-length": 10,
    "on-click": "htop"
  },
  "memory": {
    "interval": 30,
    "format": " {}% ",
    "format-alt": " {used:0.1f}G",
    "max-length": 10,
    "on-click-right": "htop"
  },
  "backlight": {
    "device": "amdgpu_bl1",
    "format": "{icon} {percent} ",
    "tooltip": false,
    "format-icons": ["", "", "", "", "", "", "", "", ""]
  },
  "network": {
    "format-wifi": "󰒢 {essid}",
    "format-alt": "󰒢 {bandwidthTotalBits}",
    "on-click-right": "nm-connection-editor",
    "format-ethernet": " wired",
    "tooltip-format": "{essid} {signalStrength}%",
    "format-disconnected": ""
  },
  "pulseaudio": {
    "format": "{icon} <b>{volume}</b>",
    "format-bluetooth": " {volume}",
    "format-bluetooth-muted": " ",
    "tooltip": false,
    "format-muted": "",
    "format-icons": {
      "default": ["󰝟", "", "󰕾", ""]
    },
    "on-click": "pactl set-sink-mute @DEFAULT_SINK@ toggle",
    "on-click-right": "pavucontrol"
  },
  "battery": {
    "bat": "BAT0",
    "interval": 30,
    "states": {
      "warning": 30,
      "critical": 15
    },
    "format": "{icon} {capacity}%",
    "format-charging": " {icon} {capacity}%",
    "format-icons": [" ", " ", " ", " "],
    "max-length": 25,
    "tooltip": false
  },
  "custom/launcher": {
    "format": " 󰣇"
  },
  "custom/separator": {
    "format": " "
  },
  "custom/pacman": {
    "format": "  ",
    "on-click": "blueberry"
  },
  "temperature": {
    "thermal-zone": 0,
    "critical-threshold": 80,
    "format-critical": " {temperatureC}°C",
    "format": " {temperatureC}°C"
  }
'

# Toggle between states
if [[ "$STATE" == "shown" ]]; then
	# Hide extra modules - switch to minimal
	echo "${MINIMAL_CONFIG%?},${MODULE_CONFIGS}}" >"$CONFIG_FILE"
	echo "hidden" >"$STATE_FILE"
else
	# Show all modules - switch to full
	echo "${FULL_CONFIG%?},${MODULE_CONFIGS}}" >"$CONFIG_FILE"
	echo "shown" >"$STATE_FILE"
fi

# Restart waybar
pkill waybar
waybar &
