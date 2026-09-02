#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reasonable Size
# @raycast.mode silent

# Documentation:
# @raycast.description Resize to 60% of screen (max 1024x900) and center

source "$(dirname "$0")/helpers/target.sh"

dx=$(echo "$display" | jq '.frame.x')
dy=$(echo "$display" | jq '.frame.y')
dw=$(echo "$display" | jq '.frame.w')
dh=$(echo "$display" | jq '.frame.h')

tw=$(echo "($dw * 0.6) / 1" | bc)
th=$(echo "($dh * 0.6) / 1" | bc)

[ "$tw" -gt 1024 ] && tw=1024
[ "$th" -gt 900 ] && th=900

nx=$(echo "$dx + ($dw - $tw) / 2" | bc)
ny=$(echo "$dy + ($dh - $th) / 2" | bc)

yabai -m window "$id" --resize abs:${tw}:${th}
yabai -m window "$id" --move abs:${nx}:${ny}
