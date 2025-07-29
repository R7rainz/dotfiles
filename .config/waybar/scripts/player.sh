#!/bin/bash

player_status=$(playerctl status 2>/dev/null)

if [[ "$player_status" == "Playing" || "$player_status" == "Paused" ]]; then
	title=$(playerctl metadata title 2>/dev/null)
	artist=$(playerctl metadata artist 2>/dev/null)

	# Limit to 50 characters total for title + artist
	text="${title} – ${artist}"
	max_length=20
	[[ ${#text} -gt $max_length ]] && text="${text:0:$max_length}..."

	echo " $text"
else
	echo "" # Just the music icon if nothing is playing
fi
