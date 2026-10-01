#!/bin/bash

resize_apps="^(Arc|iTerm2|WezTerm|Obsidian|Beekeeper Studio)$"
skip_apps="^(TodoSessions)$"
max_w=1920
max_h=1500

id=$1
mode=$2

window=$(yabai -m query --windows --window "$id" 2>/dev/null) || exit 0
display=$(yabai -m query --displays --display "$(jq '.display' <<<"$window")")
app=$(jq -r '.app' <<<"$window")

if [ "$mode" != "--force" ]; then
  [ "$(jq '.id' <<<"$display")" = "$BUILTIN_DISPLAY_ID" ] && exit 0
  [ "$(jq -r '.subrole' <<<"$window")" != "AXStandardWindow" ] && exit 0
  [ "$(jq '."is-native-fullscreen"' <<<"$window")" = "true" ] && exit 0
  [[ "$app" =~ $skip_apps ]] && exit 0
fi

if [ "$mode" = "--force" ] || [[ "$app" =~ $resize_apps ]]; then
  w=$(jq "[.frame.w, $max_w] | min | floor" <<<"$display")
  h=$(jq "[.frame.h, $max_h] | min | floor" <<<"$display")
  yabai -m window "$id" --resize abs:"$w":"$h"
  window=$(yabai -m query --windows --window "$id")
fi

x=$(jq -n --argjson d "$display" --argjson w "$window" '$d.frame.x + ($d.frame.w - $w.frame.w) / 2 | floor')
y=$(jq -n --argjson d "$display" --argjson w "$window" '$d.frame.y + ($d.frame.h - $w.frame.h) / 2 | floor')

yabai -m window "$id" --move abs:"$x":"$y"
