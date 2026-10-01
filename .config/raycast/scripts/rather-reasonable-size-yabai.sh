#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Rather Reasonable Size (yabai)
# @raycast.mode silent

# Documentation:
# @raycast.description Resize to 1920x1500 and center

source "$(dirname "$0")/helpers/target.sh"

"$HOME/.config/yabai/scripts/rather-reasonable-size.sh" "$id" --force
