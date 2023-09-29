#!/bin/bash

source "$CONFIG_DIR/icons.sh"

LAYOUT=$(xkbswitch -ge)

sketchybar --set $NAME label="$LAYOUT" icon="$KEYBOARD"
