#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Zoom Size (yabai)
# @raycast.mode silent

# Documentation:
# @raycast.description Resize to 1920x1080 and center

source "$(dirname "$0")/helpers/target.sh"

dx=$(echo "$display" | jq '.frame.x')
dy=$(echo "$display" | jq '.frame.y')
dw=$(echo "$display" | jq '.frame.w')
dh=$(echo "$display" | jq '.frame.h')

nx=$(echo "$dx + ($dw - 1920) / 2" | bc)
ny=$(echo "$dy + ($dh - 1080) / 2" | bc)

yabai -m window "$id" --resize abs:1920:1080
yabai -m window "$id" --move abs:${nx}:${ny}
