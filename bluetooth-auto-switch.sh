#!/bin/bash
# Bluetooth Auto-Switch Script for Hyprland + PipeWire
# Uses D-Bus to monitor Bluetooth connections

LOG_FILE=~/.local/share/bluetooth-auto-switch.log

# Log function for debugging
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" >> "$LOG_FILE"
}

# Function to send notification
send_notification() {
  local message="$1"
  local icon="$2"
  local urgency="${3:-normal}"

  if command -v swaync-client >/dev/null 2>&1; then
    swaync-client -n "$message" --icon "$icon" --urgency "$urgency" 2>/dev/null
  elif command -v notify-send >/dev/null 2>&1; then
    notify-send -i "$icon" -u "$urgency" "Audio Switch" "$message" 2>/dev/null
  fi
}

# Function to get current default sink
get_default_sink() {
  pactl get-default-sink 2>/dev/null
}

# Function to switch to Bluetooth
switch_to_bluetooth() {
  log "Attempting Bluetooth switch..."
  
  # Wait longer for Bluetooth audio profile to initialize
  for i in {1..6}; do
    local BT_SINK=$(pactl list short sinks | grep bluez | head -1 | awk '{print $2}')
    
    if [ -n "$BT_SINK" ]; then
      local CURRENT_SINK=$(get_default_sink)
      if [ "$CURRENT_SINK" = "$BT_SINK" ]; then
        log "Already using Bluetooth sink: $BT_SINK"
        return
      fi

      local BT_NAME=$(pactl list sinks | grep -A 20 "Name: $BT_SINK" | grep "device.description" | cut -d'"' -f2)
      log "Switching to Bluetooth: $BT_SINK ($BT_NAME)"
      
      pactl set-default-sink "$BT_SINK"
      
      # Move all current audio streams
      pactl list short sink-inputs | awk '{print $1}' | while read -r STREAM_ID; do
        pactl move-sink-input "$STREAM_ID" "$BT_SINK" 2>/dev/null
      done

      send_notification "🎧 Switched to: ${BT_NAME:-Bluetooth}" "audio-headphones" "normal"
      return
    fi
    
    log "Waiting for Bluetooth sink... attempt $i/6"
    sleep 2
  done
  
  log "No Bluetooth sink available after 12 seconds"
}

# Function to switch to speakers
switch_to_speakers() {
  local SPEAKER_SINK=$(pactl list short sinks | grep -E "(alsa|analog)" | head -1 | awk '{print $2}')

  if [ -n "$SPEAKER_SINK" ]; then
    local CURRENT_SINK=$(get_default_sink)
    if [ "$CURRENT_SINK" = "$SPEAKER_SINK" ]; then
      log "Already using speaker sink: $SPEAKER_SINK"
      return
    fi

    local SPEAKER_NAME=$(pactl list sinks | grep -A 20 "Name: $SPEAKER_SINK" | grep "device.description" | cut -d'"' -f2)
    log "Switching to speakers: $SPEAKER_SINK ($SPEAKER_NAME)"
    
    pactl set-default-sink "$SPEAKER_SINK"
    
    # Move all current audio streams
    pactl list short sink-inputs | awk '{print $1}' | while read -r STREAM_ID; do
      pactl move-sink-input "$STREAM_ID" "$SPEAKER_SINK" 2>/dev/null
    done

    send_notification "🔊 Switched to: ${SPEAKER_NAME:-Speakers}" "audio-speakers" "normal"
  else
    log "No speaker sink found"
  fi
}

# Main monitoring loop using D-Bus to catch Bluetooth connections
log "Starting D-Bus Bluetooth monitor for PipeWire audio switching"

# Wait for PipeWire to be ready
sleep 3

# Monitor Bluetooth connection/disconnection events via D-Bus
dbus-monitor --system "type='signal',interface='org.bluez.Device1',member='PropertiesChanged'" 2>/dev/null | \
  while read -r line; do
    # Look for Connected property changes
    if echo "$line" | grep -q "Connected"; then
      # Read the next line which contains the boolean value
      read -r value_line
      log "Bluetooth event: $line | $value_line"
      
      if echo "$value_line" | grep -q "true"; then
        log "Bluetooth device connected - initiating switch"
        switch_to_bluetooth
      elif echo "$value_line" | grep -q "false"; then
        log "Bluetooth device disconnected - switching to speakers"
        switch_to_speakers
      fi
    fi
  done
