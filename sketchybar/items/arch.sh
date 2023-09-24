#!/bin/bash

POPUP_OFF='sketchybar --set arch.logo popup.drawing=off'
POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'

arch_logo=(
  icon=$ARCH
  icon.font="$FONT:Heavy:20.0"
  icon.color=$ARCH_BLUE
  padding_right=15
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
)

arch_prefs=(
  icon=$PREFERENCES
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

arch_activity=(
  icon=$ACTIVITY
  label="Activity"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

arch_lock=(
  icon=$LOCK
  label="Lock Screen"
  click_script="pmset displaysleepnow; $POPUP_OFF"
)

sketchybar --add item arch.logo left                  \
           --set arch.logo "${arch_logo[@]}"         \
                                                       \
           --add item arch.prefs popup.arch.logo     \
           --set arch.prefs "${arch_prefs[@]}"       \
                                                       \
           --add item arch.activity popup.arch.logo  \
           --set arch.activity "${arch_activity[@]}" \
                                                       \
           --add item arch.lock popup.arch.logo      \
           --set arch.lock "${arch_lock[@]}"
