#!/bin/bash
# ~/.config/wofi/power-menu.sh

# Power menu options with icons
options="󰐥 Power Off\n󰍃 Reboot\n󰌾 Lock"

# Show wofi menu and capture selection
selected=$(echo -e "$options" | wofi --dmenu --cache-file=/dev/null --config ~/.config/wofi/power-menu-config --style ~/.config/wofi/style.css --prompt="Power Menu")

# Execute based on selection
case $selected in
    "󰐥 Power Off")
        systemctl poweroff
        ;;
    "󰍃 Reboot")
        systemctl reboot
        ;;
    "󰌾 Lock")
	hyprlock
        ;;
esac
