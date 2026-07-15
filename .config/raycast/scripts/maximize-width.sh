#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Maximize Width
# @raycast.mode silent

# Documentation:
# @raycast.description Maximize window width, keep current height and y position

display=$(yabai -m query --displays --display)
window=$(yabai -m query --windows --window)

dx=$(echo "$display" | jq '.frame.x')
dw=$(echo "$display" | jq '.frame.w')
wh=$(echo "$window" | jq '.frame.h')
wy=$(echo "$window" | jq '.frame.y')

yabai -m window --resize abs:${dw%.*}:${wh%.*}
yabai -m window --move abs:${dx%.*}:${wy%.*}
