keyboard=(
  padding_right=7
  icon.font="$FONT:Regular:19.0"
  script="$PLUGIN_DIR/keyboard.sh"
)

sketchybar --add item keyboard right      \
           --set keyboard "${keyboard[@]}" \
           --add event input_change AppleSelectedInputSourcesChangedNotification \
           --subscribe keyboard input_change

