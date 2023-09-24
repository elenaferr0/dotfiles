#!/bin/bash

source "$CONFIG_DIR/icons.sh"

USAGE=$(top -l 1 | grep -E '^CPU' | awk '{print $3 + $5}' | sed 's/%//' | paste -sd+ - | bc)

sketchybar --set $NAME icon=$CPU_ICON label="$USAGE%"
