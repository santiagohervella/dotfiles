#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Up
# @raycast.mode silent

# Documentation:
# @raycast.description Move window to top edge without resizing

source "$(dirname "$0")/helpers/target.sh"

dy=$(echo "$display" | jq '.frame.y | round')
wx=$(echo "$window" | jq '.frame.x | round')

yabai -m window "$id" --move abs:$wx:$dy
