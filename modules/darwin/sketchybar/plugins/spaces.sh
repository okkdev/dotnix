#!/bin/bash
source "$HOME/.config/sketchybar/icon_map.sh"

YABAI_SPACES=($(yabai -m query --spaces | jq -r '.[].index'))

for sid in "''${YABAI_SPACES[@]}"; do
  # Get windows in this space
  windows=$(yabai -m query --windows --space "$sid" | jq -r '.[] | select(.["is-minimized"] == false) | .app')

  # Create icon string from open applications
  icon_string=""
  if [[ -n "$windows" ]]; then
    while IFS= read -r app; do
      if [[ -n "$app" ]]; then
        # Get icon for this app using sketchybar-app-font
        __icon_map "$app"
        if [[ -n "$icon_result" ]]; then
          icon_string+="$icon_result"
        else
          # Fallback to first letter if no icon found
          icon_string+="${app:0:1}"
        fi
      fi
    done <<<"$windows"
  fi

  # Use space index if no windows, otherwise use app icons
  display_icon="''${icon_string:-$sid}"

  space=(
    space="$sid"
    icon="$display_icon"
    icon.font="sketchybar-app-font:Regular:16.0"
    icon.padding_left=7
    icon.padding_right=7
    background.color=0x40ffffff
    background.corner_radius=5
    background.height=25
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add spaces space."$sid" left --set space."$sid" "${space[@]}" \
    --subscribe space."$sid" space_windows_change
done
