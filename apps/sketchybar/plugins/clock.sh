#!/usr/bin/env bash

set -x

echo "YEP clock"

ICON=$(date '+%a %B %d')
LABEL=$(date '+%I:%M %p')

clock=(
  label="${LABEL:-error}"
  icon="${ICON:-error}"
)

sketchybar --set "$NAME" "${clock[@]}"
