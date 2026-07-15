#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Up
# @raycast.mode silent

# Documentation:
# @raycast.description Move window to top edge without resizing

display=$(yabai -m query --displays --display)
window=$(yabai -m query --windows --window)

dy=$(echo "$display" | jq '.frame.y | round')
wx=$(echo "$window" | jq '.frame.x | round')

yabai -m window --move abs:$wx:$dy
