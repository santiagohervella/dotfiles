#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Left
# @raycast.mode silent

# Documentation:
# @raycast.description Move window to left edge without resizing

display=$(yabai -m query --displays --display)
window=$(yabai -m query --windows --window)

dx=$(echo "$display" | jq '.frame.x | round')
wy=$(echo "$window" | jq '.frame.y | round')

yabai -m window --move abs:$dx:$wy
