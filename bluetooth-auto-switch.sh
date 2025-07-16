#!/bin/bash
# Bluetooth Auto-Switch Script for Hyprland + swaync

# Log function for debugging
log() {
  echo "$(date): $1" >>~/.local/share/bluetooth-auto-switch.log
}

# Function to send swaync popup notification (doesn't open panel)
send_notification() {
  local message="$1"
  local icon="$2"
  local urgency="${3:-normal}"

  if command -v swaync-client >/dev/null 2>&1; then
    # Use -n flag to send notification without opening the panel
    swaync-client -n "$message" --icon "$icon" --urgency "$urgency"
  elif command -v notify-send >/dev/null 2>&1; then
    notify-send -i "$icon" -u "$urgency" "Audio Switch" "$message"
  fi
}

# Function to switch to Bluetooth
switch_to_bluetooth() {
  sleep 3 # Wait for A2DP profile to be available

  BT_SINK=$(pactl list short sinks | grep bluez | head -1 | cut -f1)
  BT_NAME=$(pactl list sinks | grep -A 20 "Name: $BT_SINK" | grep "device.description" | cut -d'"' -f2)

  if [ -n "$BT_SINK" ]; then
    log "Automatically switching to Bluetooth: $BT_SINK ($BT_NAME)"
    pactl set-default-sink "$BT_SINK"

    # Move all current audio streams to Bluetooth
    pactl list short sink-inputs | while read -r stream; do
      STREAM_ID=$(echo "$stream" | cut -f1)
      pactl move-sink-input "$STREAM_ID" "$BT_SINK" 2>/dev/null
    done

    send_notification "🎧 Audio auto-switched to: ${BT_NAME:-Bluetooth Device}" "audio-headphones" "normal"
  else
    log "No Bluetooth sink found"
  fi
}

# Function to switch to speakers
switch_to_speakers() {
  SPEAKER_SINK=$(pactl list short sinks | grep -E "(alsa|analog)" | head -1 | cut -f1)
  SPEAKER_NAME=$(pactl list sinks | grep -A 20 "Name: $SPEAKER_SINK" | grep "device.description" | cut -d'"' -f2)

  if [ -n "$SPEAKER_SINK" ]; then
    log "Automatically switching to speakers: $SPEAKER_SINK ($SPEAKER_NAME)"
    pactl set-default-sink "$SPEAKER_SINK"

    # Move all current audio streams to speakers
    pactl list short sink-inputs | while read -r stream; do
      STREAM_ID=$(echo "$stream" | cut -f1)
      pactl move-sink-input "$STREAM_ID" "$SPEAKER_SINK" 2>/dev/null
    done

    send_notification "🔊 Audio auto-switched to: ${SPEAKER_NAME:-Built-in Audio}" "audio-speakers" "normal"
  else
    log "No speaker sink found"
  fi
}

# Main monitoring loop - THIS RUNS AUTOMATICALLY
log "Starting automatic Bluetooth audio monitor for Hyprland"

# Wait for audio system to be ready
sleep 2

# This monitors Bluetooth connections automatically
bluetoothctl | while read -r line; do
  if echo "$line" | grep -q "Device.*Connected: yes"; then
    log "Bluetooth device connected - auto-switching"
    switch_to_bluetooth
  elif echo "$line" | grep -q "Device.*Connected: no"; then
    log "Bluetooth device disconnected - auto-switching"
    switch_to_speakers
  fi
done
