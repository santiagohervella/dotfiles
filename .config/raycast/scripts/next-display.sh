#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Next Display
# @raycast.mode silent

# Documentation:
# @raycast.description Move window to next display, preserving size

HELPERS_DIR="$(dirname "$0")/helpers"

current_idx=$(yabai -m query --displays --display | jq '.index')
display_count=$(yabai -m query --displays | jq 'length')
next_idx=$(( (current_idx % display_count) + 1 ))

bash "$HELPERS_DIR/move-to-display.sh" $next_idx
