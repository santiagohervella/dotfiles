#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Down
# @raycast.mode silent

# Documentation:
# @raycast.description Move window to bottom edge without resizing

display=$(yabai -m query --displays --display)
window=$(yabai -m query --windows --window)

dy=$(echo "$display" | jq '.frame.y')
dh=$(echo "$display" | jq '.frame.h')
wh=$(echo "$window" | jq '.frame.h')
wx=$(echo "$window" | jq '.frame.x | round')

ny=$(echo "$dy + $dh - $wh" | bc | xargs printf '%.0f')

yabai -m window --move abs:$wx:$ny
