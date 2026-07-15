#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Right
# @raycast.mode silent

# Documentation:
# @raycast.description Move window to right edge without resizing

display=$(yabai -m query --displays --display)
window=$(yabai -m query --windows --window)

dx=$(echo "$display" | jq '.frame.x')
dw=$(echo "$display" | jq '.frame.w')
ww=$(echo "$window" | jq '.frame.w')
wy=$(echo "$window" | jq '.frame.y | round')

nx=$(echo "$dx + $dw - $ww" | bc | xargs printf '%.0f')

yabai -m window --move abs:$nx:$wy
