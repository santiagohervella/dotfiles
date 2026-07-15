#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Maximize Height
# @raycast.mode silent

# Documentation:
# @raycast.description Maximize window height, keep current width and x position

display=$(yabai -m query --displays --display)
window=$(yabai -m query --windows --window)

dy=$(echo "$display" | jq '.frame.y')
dh=$(echo "$display" | jq '.frame.h')
ww=$(echo "$window" | jq '.frame.w')
wx=$(echo "$window" | jq '.frame.x')

yabai -m window --resize abs:${ww%.*}:${dh%.*}
yabai -m window --move abs:${wx%.*}:${dy%.*}
