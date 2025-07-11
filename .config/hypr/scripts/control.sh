#!/bin/bash

# Volume Control Script (~/.config/hypr/scripts/volume_control.sh)
# Make sure to chmod +x this script

volume_up() {
  pamixer --allow-boost -i 5
  volume=$(pamixer --get-volume)
  muted=$(pamixer --get-mute)

  if [ "$muted" = "true" ]; then
    icon="🔇"
    text="Muted"
  else
    if [ "$volume" -ge 70 ]; then
      icon="🔊"
    elif [ "$volume" -ge 30 ]; then
      icon="🔉"
    else
      icon="🔈"
    fi
    text="$volume%"
  fi

  # Play sound
  paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga &

  # Send notification
  notify-send -a "Volume Control" -u low -i audio-volume-high -h int:value:"$volume" -h string:synchronous:volume "$icon Volume" "$text"
}

volume_down() {
  pamixer -d 5
  volume=$(pamixer --get-volume)
  muted=$(pamixer --get-mute)

  if [ "$muted" = "true" ]; then
    icon="🔇"
    text="Muted"
  else
    if [ "$volume" -ge 70 ]; then
      icon="🔊"
    elif [ "$volume" -ge 30 ]; then
      icon="🔉"
    else
      icon="🔈"
    fi
    text="$volume%"
  fi

  # Play sound
  paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga &

  # Send notification
  notify-send -a "Volume Control" -u low -i audio-volume-low -h int:value:"$volume" -h string:synchronous:volume "$icon Volume" "$text"
}

volume_mute() {
  pamixer -t
  muted=$(pamixer --get-mute)
  volume=$(pamixer --get-volume)

  if [ "$muted" = "true" ]; then
    icon="🔇"
    text="Muted"
    notify-send -a "Volume Control" -u low -i audio-volume-muted -h string:synchronous:volume "$icon Volume" "$text"
  else
    if [ "$volume" -ge 70 ]; then
      icon="🔊"
    elif [ "$volume" -ge 30 ]; then
      icon="🔉"
    else
      icon="🔈"
    fi
    text="$volume%"
    notify-send -a "Volume Control" -u low -i audio-volume-high -h int:value:"$volume" -h string:synchronous:volume "$icon Volume" "$text"
  fi
}

# Brightness Control Script (~/.config/hypr/scripts/brightness_control.sh)
# Make sure to chmod +x this script

brightness_up() {
  brightnessctl set +5%
  brightness=$(brightnessctl get)
  max_brightness=$(brightnessctl max)
  percentage=$((brightness * 100 / max_brightness))

  if [ "$percentage" -ge 80 ]; then
    icon="☀️"
  elif [ "$percentage" -ge 50 ]; then
    icon="🔆"
  elif [ "$percentage" -ge 20 ]; then
    icon="🔅"
  else
    icon="🌙"
  fi

  # Send notification
  notify-send -a "Brightness Control" -u low -i brightness-high -h int:value:"$percentage" -h string:synchronous:brightness "$icon Brightness" "$percentage%"
}

brightness_down() {
  brightnessctl set 5%-
  brightness=$(brightnessctl get)
  max_brightness=$(brightnessctl max)
  percentage=$((brightness * 100 / max_brightness))

  if [ "$percentage" -ge 80 ]; then
    icon="☀️"
  elif [ "$percentage" -ge 50 ]; then
    icon="🔆"
  elif [ "$percentage" -ge 20 ]; then
    icon="🔅"
  else
    icon="🌙"
  fi

  # Send notification
  notify-send -a "Brightness Control" -u low -i brightness-low -h int:value:"$percentage" -h string:synchronous:brightness "$icon Brightness" "$percentage%"
}

# Check command line arguments
case "$1" in
"volume-up")
  volume_up
  ;;
"volume-down")
  volume_down
  ;;
"volume-mute")
  volume_mute
  ;;
"brightness-up")
  brightness_up
  ;;
"brightness-down")
  brightness_down
  ;;
*)
  echo "Usage: $0 {volume-up|volume-down|volume-mute|brightness-up|brightness-down}"
  exit 1
  ;;
esac
