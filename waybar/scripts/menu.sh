#!/bin/bash
# Create this script for the custom menu module

# Get OS info
OS_INFO=$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f2)

# Check if window is fullscreen (for Hyprland)
if command -v hyprctl >/dev/null 2>&1; then
    if hyprctl activewindow -j 2>/dev/null | jq -e '.fullscreen' &>/dev/null; then
        CLASS="fullscreen"
    else
        CLASS=""
    fi
else
    CLASS=""
fi

# Output JSON for waybar
jq -cn \
  --arg text "" \
  --arg tooltip "$OS_INFO" \
  --arg alt "" \
  --arg class "$CLASS" \
  --arg percentage "" \
  '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
