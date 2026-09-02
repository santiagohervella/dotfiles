#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Left
# @raycast.mode silent

# Documentation:
# @raycast.description Move window to left edge without resizing

source "$(dirname "$0")/helpers/target.sh"

dx=$(echo "$display" | jq '.frame.x | round')
wy=$(echo "$window" | jq '.frame.y | round')

yabai -m window "$id" --move abs:$dx:$wy
