#!/bin/bash

cpu=(
  padding_right=7
  icon.font="$FONT:Regular:19.0"
  script="$PLUGIN_DIR/cpu.sh"
  update_freq=120
  updates=on
)

sketchybar --add item cpu right      \
           --set cpu "${cpu[@]}"
