#!/usr/bin/env bash

declare -A SPACE_ICONS=(
  ["1"]="$HOME_ICON"
  ["2"]="$BROWSER_ICON"
  ["3"]="$DISCORD_ICON"
  ["4"]="4" 
  ["5"]="$OBSIDIAN_ICON"
  ["6"]="6"
  ["7"]="7"
  ["8"]="$MAIL_ICON" 
  ["T"]="$TERMINAL_ICON"
)

sketchybar --add event aerospace_workspace_change

FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"

for sid in $(aerospace list-workspaces --all); do
  if [ -z "${SPACE_ICONS["${sid}"]}" ]; then
    continue
  fi

  workspace=(
    label.drawing=off
    # display=1
    icon="${SPACE_ICONS["${sid}"]}" 
    icon.padding_left=8
    icon.padding_right=8
    icon.background.drawing=off

    click_script="aerospace workspace ${sid}" 
    script="plugin_aerospace ${sid}"
  ) 

  sketchybar --add item "space.${sid}" left \
    --subscribe "space.${sid}" aerospace_workspace_change \
    --set "space.${sid}" "${workspace[@]}" 

    FOCUSED_WORKSPACE="$FOCUSED_WORKSPACE" NAME="space.${sid}" plugin_aerospace "${sid}" &
done

wrapper=(
  background.color="$SPACES_WRAPPER_BACKGROUND"
  background.border_color="$SPACES_ITEM_BACKGROUND"
  background.border_width=2
  background.drawing=on
)

separator=(
  icon=􀆊
  icon.font="$ICON_FONT:Heavy:16.0"
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  icon.color="$ICON_COLOR"
)

sketchybar --add bracket wrapper '/space\..*/' \
  --set wrapper "${wrapper[@]}"        

sketchybar --add item separator left \
  --set separator "${separator[@]}"
