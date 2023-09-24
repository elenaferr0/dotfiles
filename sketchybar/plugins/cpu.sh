#!/bin/bash

source "$CONFIG_DIR/icons.sh"

USAGE=$(istats all | grep 'CPU temp' | awk '{print $3}')

sketchybar --set $NAME label="CPU: $USAGE"
