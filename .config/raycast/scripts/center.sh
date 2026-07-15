#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Center
# @raycast.mode silent

# Documentation:
# @raycast.description Center window on screen without resizing

display=$(yabai -m query --displays --display)
window=$(yabai -m query --windows --window)

dx=$(echo "$display" | jq '.frame.x')
dy=$(echo "$display" | jq '.frame.y')
dw=$(echo "$display" | jq '.frame.w')
dh=$(echo "$display" | jq '.frame.h')
ww=$(echo "$window" | jq '.frame.w')
wh=$(echo "$window" | jq '.frame.h')

nx=$(echo "$dx + ($dw - $ww) / 2" | bc)
ny=$(echo "$dy + ($dh - $wh) / 2" | bc)

yabai -m window --move abs:${nx}:${ny}
