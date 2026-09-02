#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Maximize Width
# @raycast.mode silent

# Documentation:
# @raycast.description Maximize window width, keep current height and y position

source "$(dirname "$0")/helpers/target.sh"

dx=$(echo "$display" | jq '.frame.x')
dw=$(echo "$display" | jq '.frame.w')
wh=$(echo "$window" | jq '.frame.h')
wy=$(echo "$window" | jq '.frame.y')

yabai -m window "$id" --resize abs:${dw%.*}:${wh%.*}
yabai -m window "$id" --move abs:${dx%.*}:${wy%.*}
