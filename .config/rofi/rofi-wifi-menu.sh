#!/bin/bash
# Save as ~/.config/rofi/rofi-wifi-menu.sh and make executable

# Get list of available WiFi networks
wifi_list=$(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi | grep -v "^--" | sort -t: -k2 -nr)

# Format for rofi display
formatted_list=""
while IFS=: read -r ssid signal security; do
	if [[ -n "$ssid" ]]; then
		# Add security icon
		if [[ "$security" == *"WPA"* ]]; then
			sec_icon="🔒"
		else
			sec_icon="🔓"
		fi

		# Format signal strength
		if [[ $signal -gt 70 ]]; then
			signal_icon="󰒢"
		elif [[ $signal -gt 50 ]]; then
			signal_icon="󰒢"
		elif [[ $signal -gt 30 ]]; then
			signal_icon="󰒢"
		else
			signal_icon="󰒢"
		fi

		formatted_list+="$sec_icon $signal_icon $ssid ($signal%)\n"
	fi
done <<<"$wifi_list"

# Add disconnect option
formatted_list+="🔌 Disconnect\n"
formatted_list+="🔄 Refresh\n"

# Show rofi menu
selected=$(echo -e "$formatted_list" | rofi -dmenu -i -p "WiFi Networks" -theme-str 'window {width: 400px;}')

if [[ -n "$selected" ]]; then
	if [[ "$selected" == *"Disconnect"* ]]; then
		nmcli device disconnect wlan0
		notify-send "WiFi" "Disconnected from WiFi"
	elif [[ "$selected" == *"Refresh"* ]]; then
		nmcli device wifi rescan
		notify-send "WiFi" "Rescanning networks..."
		# Rerun script
		exec "$0"
	else
		# Extract SSID from selection
		ssid=$(echo "$selected" | sed 's/^[🔒🔓] [󰒢] \(.*\) ([0-9]*%)$/\1/')

		# Check if network requires password
		security=$(nmcli -t -f SSID,SECURITY dev wifi | grep "^$ssid:" | cut -d: -f2)

		if [[ "$security" == *"WPA"* ]]; then
			password=$(rofi -dmenu -password -p "Password for $ssid")
			if [[ -n "$password" ]]; then
				if nmcli device wifi connect "$ssid" password "$password"; then
					notify-send "WiFi" "Connected to $ssid"
				else
					notify-send "WiFi" "Failed to connect to $ssid"
				fi
			fi
		else
			if nmcli device wifi connect "$ssid"; then
				notify-send "WiFi" "Connected to $ssid"
			else
				notify-send "WiFi" "Failed to connect to $ssid"
			fi
		fi
	fi
fi
