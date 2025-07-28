#!/bin/bash
# Save as ~/.config/rofi/wifi-menu.sh and make executable
# Advanced Rofi WiFi Manager with security options and certificate handling

# Check if NetworkManager is running
if ! systemctl is-active --quiet NetworkManager; then
	notify-send "WiFi Error" "NetworkManager is not running"
	exit 1
fi

# Function to get WiFi list
get_wifi_list() {
	nmcli -t -f SSID,SIGNAL,SECURITY,ACTIVE device wifi list |
		awk -F: '
    $1 != "" && $1 != "--" {
        ssid = $1
        signal = $2
        security = $3
        active = $4
        
        # Security icon
        if (security ~ /WPA3/) {
            sec_icon = "🔐"
        } else if (security ~ /WPA2|WPA/) {
            sec_icon = "🔒"
        } else if (security ~ /WEP/) {
            sec_icon = "🔑"
        } else {
            sec_icon = "🔓"
        }
        
        # Signal strength icon
        if (signal > 75) {
            sig_icon = "▂▄▆█"
        } else if (signal > 50) {
            sig_icon = "▂▄▆_"
        } else if (signal > 25) {
            sig_icon = "▂▄__"
        } else {
            sig_icon = "▂___"
        }
        
        # Active connection indicator
        if (active == "yes") {
            printf "✓ %s %s %s (%s%%) [%s]\n", sec_icon, sig_icon, ssid, signal, security
        } else {
            printf "  %s %s %s (%s%%) [%s]\n", sec_icon, sig_icon, ssid, signal, security
        }
    }' | sort -k5 -nr
}

# Function to handle enterprise WiFi connection
connect_enterprise_wifi() {
	local ssid="$1"
	local security="$2"

	# Check if it's an enterprise network
	if [[ "$security" =~ "802.1X" ]] || [[ "$security" =~ "WPA.*EAP" ]]; then
		# Enterprise network detected
		notify-send "WiFi" "Enterprise network detected. Configuring..."

		# Get EAP method
		eap_method=$(echo -e "PEAP\nTTLS\nTLS\nPWD\nFAST" | rofi -dmenu -p "Select EAP method:")

		if [[ -z "$eap_method" ]]; then
			return 1
		fi

		case "$eap_method" in
		"PEAP" | "TTLS")
			# Username/password based
			username=$(rofi -dmenu -p "Username:")
			if [[ -z "$username" ]]; then
				return 1
			fi

			password=$(rofi -dmenu -password -p "Password:")
			if [[ -z "$password" ]]; then
				return 1
			fi

			# Optional: CA certificate
			use_ca=$(echo -e "Yes\nNo\nIgnore" | rofi -dmenu -p "Use CA certificate?")

			case "$use_ca" in
			"Yes")
				ca_cert=$(rofi -dmenu -p "CA certificate path:" -filter "/etc/ssl/certs/")
				if [[ -f "$ca_cert" ]]; then
					nmcli connection add type wifi con-name "$ssid" ssid "$ssid" \
						wifi-sec.key-mgmt wpa-eap \
						802-1x.eap "$eap_method" \
						802-1x.identity "$username" \
						802-1x.password "$password" \
						802-1x.ca-cert "$ca_cert"
				else
					notify-send "WiFi Error" "CA certificate not found"
					return 1
				fi
				;;
			"Ignore")
				nmcli connection add type wifi con-name "$ssid" ssid "$ssid" \
					wifi-sec.key-mgmt wpa-eap \
					802-1x.eap "$eap_method" \
					802-1x.identity "$username" \
					802-1x.password "$password" \
					802-1x.system-ca-certs no
				;;
			*)
				nmcli connection add type wifi con-name "$ssid" ssid "$ssid" \
					wifi-sec.key-mgmt wpa-eap \
					802-1x.eap "$eap_method" \
					802-1x.identity "$username" \
					802-1x.password "$password"
				;;
			esac

			# Additional phase2 auth for PEAP/TTLS
			if [[ "$eap_method" == "PEAP" ]] || [[ "$eap_method" == "TTLS" ]]; then
				phase2=$(echo -e "MSCHAPv2\nMD5\nGTC\nPAP\nCHAP\nMSCHAP" | rofi -dmenu -p "Phase2 auth (optional):")
				if [[ -n "$phase2" ]]; then
					nmcli connection modify "$ssid" 802-1x.phase2-auth "$phase2"
				fi
			fi
			;;

		"TLS")
			# Certificate-based authentication
			username=$(rofi -dmenu -p "Identity/Username:")
			if [[ -z "$username" ]]; then
				return 1
			fi

			client_cert=$(rofi -dmenu -p "Client certificate path:" -filter "/home/$USER/")
			if [[ ! -f "$client_cert" ]]; then
				notify-send "WiFi Error" "Client certificate not found"
				return 1
			fi

			private_key=$(rofi -dmenu -p "Private key path:" -filter "/home/$USER/")
			if [[ ! -f "$private_key" ]]; then
				notify-send "WiFi Error" "Private key not found"
				return 1
			fi

			# Private key password (optional)
			key_password=$(rofi -dmenu -password -p "Private key password (optional):")

			ca_cert=$(rofi -dmenu -p "CA certificate path (optional):" -filter "/etc/ssl/certs/")

			# Create TLS connection
			if [[ -f "$ca_cert" ]]; then
				nmcli connection add type wifi con-name "$ssid" ssid "$ssid" \
					wifi-sec.key-mgmt wpa-eap \
					802-1x.eap tls \
					802-1x.identity "$username" \
					802-1x.client-cert "$client_cert" \
					802-1x.private-key "$private_key" \
					802-1x.ca-cert "$ca_cert"
			else
				nmcli connection add type wifi con-name "$ssid" ssid "$ssid" \
					wifi-sec.key-mgmt wpa-eap \
					802-1x.eap tls \
					802-1x.identity "$username" \
					802-1x.client-cert "$client_cert" \
					802-1x.private-key "$private_key"
			fi

			# Set private key password if provided
			if [[ -n "$key_password" ]]; then
				nmcli connection modify "$ssid" 802-1x.private-key-password "$key_password"
			fi
			;;

		"PWD" | "FAST")
			# Simple username/password for PWD and FAST
			username=$(rofi -dmenu -p "Username:")
			if [[ -z "$username" ]]; then
				return 1
			fi

			password=$(rofi -dmenu -password -p "Password:")
			if [[ -z "$password" ]]; then
				return 1
			fi

			nmcli connection add type wifi con-name "$ssid" ssid "$ssid" \
				wifi-sec.key-mgmt wpa-eap \
				802-1x.eap "$eap_method" \
				802-1x.identity "$username" \
				802-1x.password "$password"
			;;
		esac

		# Try to connect
		if nmcli connection up "$ssid"; then
			notify-send "WiFi" "Connected to enterprise network: $ssid"
			return 0
		else
			notify-send "WiFi Error" "Failed to connect to enterprise network: $ssid"
			# Remove failed connection
			nmcli connection delete "$ssid" 2>/dev/null
			return 1
		fi
	else
		return 1
	fi
}

# Function to handle WPS connection
connect_wps() {
	local ssid="$1"

	wps_method=$(echo -e "PIN\nPush Button" | rofi -dmenu -p "WPS Method:")

	case "$wps_method" in
	"PIN")
		wps_pin=$(rofi -dmenu -p "Enter WPS PIN:")
		if [[ -n "$wps_pin" ]]; then
			notify-send "WiFi" "Connecting via WPS PIN..."
			if nmcli device wifi connect "$ssid" wep-key-type key wep-key0 "$wps_pin"; then
				notify-send "WiFi" "Connected via WPS PIN"
				return 0
			fi
		fi
		;;
	"Push Button")
		notify-send "WiFi" "Press WPS button on router now..."
		sleep 3
		if nmcli device wifi connect "$ssid"; then
			notify-send "WiFi" "Connected via WPS Push Button"
			return 0
		fi
		;;
	esac

	return 1
}

# Function to show advanced connection options
show_advanced_options() {
	local ssid="$1"
	local security="$2"

	advanced_option=$(echo -e "🔑 Standard Connection\n🏢 Enterprise (802.1X)\n📶 WPS Connection\n🔧 Manual Configuration\n❌ Cancel" | rofi -dmenu -p "Connection method for $ssid:")

	case "$advanced_option" in
	"🔑 Standard Connection")
		return 1 # Fall back to standard connection
		;;
	"🏢 Enterprise (802.1X)")
		connect_enterprise_wifi "$ssid" "$security"
		return $?
		;;
	"📶 WPS Connection")
		connect_wps "$ssid"
		return $?
		;;
	"🔧 Manual Configuration")
		# Open network manager GUI for manual configuration
		if command -v nm-connection-editor >/dev/null 2>&1; then
			notify-send "WiFi" "Opening Network Manager for manual configuration..."
			nm-connection-editor &
		else
			notify-send "WiFi Error" "Network Manager GUI not available"
		fi
		return 0
		;;
	*)
		return 0 # Cancel
		;;
	esac
}

# Function to handle hidden networks
connect_hidden_network() {
	ssid=$(rofi -dmenu -p "Hidden network SSID:")
	if [[ -z "$ssid" ]]; then
		return 1
	fi

	security_type=$(echo -e "WPA2/WPA3 Personal\nWPA2/WPA3 Enterprise\nWEP\nOpen\nCancel" | rofi -dmenu -p "Security type:")

	case "$security_type" in
	"WPA2/WPA3 Personal")
		password=$(rofi -dmenu -password -p "Password for $ssid:")
		if [[ -n "$password" ]]; then
			nmcli connection add type wifi con-name "$ssid" ssid "$ssid" wifi-sec.key-mgmt wpa-psk wifi-sec.psk "$password"
			nmcli connection up "$ssid"
		fi
		;;
	"WPA2/WPA3 Enterprise")
		connect_enterprise_wifi "$ssid" "WPA2-EAP"
		;;
	"WEP")
		wep_key=$(rofi -dmenu -password -p "WEP key for $ssid:")
		if [[ -n "$wep_key" ]]; then
			nmcli connection add type wifi con-name "$ssid" ssid "$ssid" wifi-sec.key-mgmt none wifi-sec.wep-key0 "$wep_key"
			nmcli connection up "$ssid"
		fi
		;;
	"Open")
		nmcli connection add type wifi con-name "$ssid" ssid "$ssid"
		nmcli connection up "$ssid"
		;;
	esac
}

# Get current connection
current_conn=$(nmcli -t -f NAME connection show --active | head -n1)

# Create menu options
menu_options="🔄 Refresh Networks
🔌 Disconnect WiFi
🔍 Connect to Hidden Network
📋 Manage Saved Networks
$(get_wifi_list)"

# Show rofi menu
selected=$(echo "$menu_options" | rofi -dmenu -i -p "WiFi: $current_conn" -no-custom -theme-str 'window {width: 500px;}' -lines 15)

# Handle selection
case "$selected" in
"🔄 Refresh Networks")
	nmcli device wifi rescan
	notify-send "WiFi" "Rescanning networks..."
	sleep 2
	exec "$0"
	;;
"🔌 Disconnect WiFi")
	# Get current WiFi device
	wifi_device=$(nmcli -t -f DEVICE,TYPE device | grep ':wifi$' | cut -d: -f1 | head -n1)
	if [[ -n "$wifi_device" ]]; then
		nmcli device disconnect "$wifi_device"
		notify-send "WiFi" "Disconnected from WiFi"
	else
		notify-send "WiFi Error" "No WiFi device found"
	fi
	;;
"🔍 Connect to Hidden Network")
	connect_hidden_network
	;;
"📋 Manage Saved Networks")
	saved_networks=$(nmcli -t -f NAME,TYPE connection show | grep ':.*wifi$' | cut -d: -f1)
	if [[ -n "$saved_networks" ]]; then
		selected_saved=$(echo "$saved_networks" | rofi -dmenu -p "Manage saved networks:")
		if [[ -n "$selected_saved" ]]; then
			action=$(echo -e "Connect\nDelete\nEdit\nCancel" | rofi -dmenu -p "Action for $selected_saved:")
			case "$action" in
			"Connect")
				nmcli connection up "$selected_saved"
				notify-send "WiFi" "Connecting to $selected_saved"
				;;
			"Delete")
				if nmcli connection delete "$selected_saved"; then
					notify-send "WiFi" "Deleted saved network: $selected_saved"
				fi
				;;
			"Edit")
				if command -v nm-connection-editor >/dev/null 2>&1; then
					nm-connection-editor --edit="$selected_saved" &
				else
					notify-send "WiFi" "Network Manager GUI not available"
				fi
				;;
			esac
		fi
	else
		notify-send "WiFi" "No saved networks found"
	fi
	;;
"")
	exit 0
	;;
*)
	if [[ -n "$selected" ]]; then
		# Extract SSID and security info from selection
		ssid=$(echo "$selected" | sed -E 's/^[✓ ]*[🔐🔒🔑🔓] [▂▄▆█_]+ (.*) \([0-9]+%\) \[.*\]$/\1/')
		security=$(echo "$selected" | sed -E 's/^.*\[([^\]]+)\]$/\1/')

		# Check if already connected
		if [[ "$selected" == "✓"* ]]; then
			notify-send "WiFi" "Already connected to $ssid"
			exit 0
		fi

		# For enterprise networks or user request, show advanced options
		if [[ "$security" =~ "802.1X" ]] || [[ "$security" =~ "WPA.*EAP" ]]; then
			show_advanced_options "$ssid" "$security"
			exit 0
		fi

		# Check if user wants advanced options (right-click simulation via modifier key)
		if [[ "$1" == "--advanced" ]]; then
			show_advanced_options "$ssid" "$security"
			exit 0
		fi

		# Try standard connection first
		if nmcli device wifi connect "$ssid" 2>/dev/null; then
			notify-send "WiFi" "Connected to $ssid"
		else
			# Network requires password or advanced configuration
			if [[ "$security" =~ "WPA|WEP" ]]; then
				# Show advanced options for secured networks
				if ! show_advanced_options "$ssid" "$security"; then
					# Fall back to simple password prompt
					password=$(rofi -dmenu -password -p "Password for $ssid:")
					if [[ -n "$password" ]]; then
						if nmcli device wifi connect "$ssid" password "$password"; then
							notify-send "WiFi" "Connected to $ssid"
						else
							notify-send "WiFi Error" "Failed to connect to $ssid"
						fi
					fi
				fi
			else
				notify-send "WiFi Error" "Failed to connect to $ssid"
			fi
		fi
	fi
	;;
esac
