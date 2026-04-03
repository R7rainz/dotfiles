#!/bin/bash
wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05- # decrease 5%
current=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
avizo-send "Volume: $current%"
