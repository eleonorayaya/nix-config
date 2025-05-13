#!/usr/bin/env bash

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

apple_logo=(
  icon="$HERO_ICON"
  icon.padding_left=4
  icon.padding_right=16
  icon.font="$FONT:Regular:18"
  icon.color="$WHITE"
  icon.drawing=on

  label.drawing=off

  padding_left=4
  padding_right=4

  click_script="$POPUP_CLICK_SCRIPT"          
)

apple_prefs=(
  icon="$PREFERENCES_ICON"
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

apple_activity=(
  icon="$ACTIVITY_ICON"
  label="Activity"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

apple_lock=(
  icon="$LOCK_ICON"
  label="Lock Screen"
  click_script="pmset displaysleepnow; $POPUP_OFF"
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
                                                       \
           --add item apple.prefs popup.apple.logo     \
           --set apple.prefs "${apple_prefs[@]}"       \
                                                       \
           --add item apple.activity popup.apple.logo  \
           --set apple.activity "${apple_activity[@]}" \
                                                       \
           --add item apple.lock popup.apple.logo      \
           --set apple.lock "${apple_lock[@]}"
