#!/bin/bash

# Audio visualizer for Waybar using the same bar characters as CPU
BARS=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Cache file for smoother transitions
CACHE_FILE="/tmp/waybar_audio_viz_cache"

# Check if any audio is playing
if playerctl status 2>/dev/null | grep -q "Playing"; then
	# Get current audio volume/activity level
	VOLUME=$(pactl list sinks | grep "Volume: front" | head -n1 | awk '{print $5}' | sed 's/%//')

	# Read previous values for smoother animation
	if [ -f "$CACHE_FILE" ]; then
		readarray -t PREV_VALS <"$CACHE_FILE"
	else
		PREV_VALS=(3 2 4 3 2)
	fi

	# Generate bars with smoother transitions
	OUTPUT=""
	NEW_VALS=()
	NUM_BARS=5

	for i in $(seq 0 $((NUM_BARS - 1))); do
		PREV_VAL=${PREV_VALS[$i]:-3}

		# Random change but limited to ±2 from previous value for smoothness
		CHANGE=$(((RANDOM % 5) - 2))
		NEW_VAL=$((PREV_VAL + CHANGE))

		# Influence by volume
		if [ "$VOLUME" -gt 70 ]; then
			MAX_HEIGHT=7
		elif [ "$VOLUME" -gt 40 ]; then
			MAX_HEIGHT=5
		elif [ "$VOLUME" -gt 20 ]; then
			MAX_HEIGHT=4
		else
			MAX_HEIGHT=3
		fi

		# Clamp values
		[ $NEW_VAL -lt 0 ] && NEW_VAL=0
		[ $NEW_VAL -gt $MAX_HEIGHT ] && NEW_VAL=$MAX_HEIGHT

		NEW_VALS+=($NEW_VAL)
		OUTPUT="${OUTPUT}${BARS[$NEW_VAL]}"
	done

	# Save current values for next iteration
	printf "%s\n" "${NEW_VALS[@]}" >"$CACHE_FILE"

	echo "$OUTPUT"
else
	# When no audio is playing, show flat line
	echo "▁▁▁▁▁"
	# Reset cache
	rm -f "$CACHE_FILE"
fi
