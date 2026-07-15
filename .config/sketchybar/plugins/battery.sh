#!/bin/bash

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

if [[ "$CHARGING" != "" ]]; then
  ICON=$'\xef\x89\xa3'
else
  ICON=""
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.drawing=$([ -n "$ICON" ] && echo "on" || echo "off") \
  icon.font="MesloLGS Nerd Font:Bold:16.0" \
  label="${PERCENTAGE}%"
