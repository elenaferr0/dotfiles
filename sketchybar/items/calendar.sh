#!/bin/bash

calendar=(
  icon=cal
  icon.font="$FONT:Semibold:14.0"
  icon.padding_right=10
  label.width=45
  label.align=center
  label.font="$FONT:Regular:14.0"
  padding_left=15
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar center       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
