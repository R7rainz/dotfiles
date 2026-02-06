#!/bin/bash
# Monitor and fix Bluetooth volume when it gets capped

dbus-monitor --system "type='signal',interface='org.bluez.Device1',member='PropertiesChanged'" 2>/dev/null | \
  while read -r line; do
    if echo "$line" | grep -q "Connected"; then
      read -r value_line
      if echo "$value_line" | grep -q "true"; then
        # Wait for audio sink to be ready
        sleep 3
        BT_SINK=$(pactl list short sinks | grep bluez | head -1 | awk '{print $2}')
        if [ -n "$BT_SINK" ]; then
          pactl set-sink-volume "$BT_SINK" 100%
          echo "$(date): Set $BT_SINK to 100%" >> ~/.local/share/bluetooth-volume-fix.log
        fi
      fi
    fi
  done
