#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Previous Display
# @raycast.mode silent

# Documentation:
# @raycast.description Move window to previous display, preserving size

HELPERS_DIR="$(dirname "$0")/helpers"

current_idx=$(yabai -m query --displays --display | jq '.index')
display_count=$(yabai -m query --displays | jq 'length')
prev_idx=$(( ((current_idx - 2 + display_count) % display_count) + 1 ))

bash "$HELPERS_DIR/move-to-display.sh" $prev_idx
