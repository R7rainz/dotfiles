#!/bin/bash

case "$1" in
up)
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
	;;
down)
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
	;;
mute)
	mute_state=$(wpctl get-mute @DEFAULT_AUDIO_SINK@)
	if [ "$mute_state" = "true" ]; then
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 # unmute
	else
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 # mute
	fi
	;;
*)
	echo "Usage: volumectl {up|down|mute}"
	exit 1
	;;
esac

# trigger the Avizo HUD
/usr/local/bin/avizo-client
