#!/bin/bash

source "$CONFIG_DIR/icons.sh"

ISTATS_PATH=$(which istats)
TEMP=$($ISTATS_PATH cpu | awk '{print $3}')
sketchybar --set $NAME label="CPU: $TEMP"
