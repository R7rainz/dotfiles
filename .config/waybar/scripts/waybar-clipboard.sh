#!/bin/bash

selection=$(cliphist list | rofi -dmenu -p "Clipboard")

if [ -n "$selection" ]; then
	cliphist decode <<<"$selection" | wl-copy
fi
