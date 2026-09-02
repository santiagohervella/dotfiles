#!/bin/bash

window=$(yabai -m query --windows --window 2>/dev/null)
id=$(echo "$window" | jq -r '.id // empty')

[ -z "$id" ] && exit 1

display=$(yabai -m query --displays --display "$(echo "$window" | jq '.display')")
