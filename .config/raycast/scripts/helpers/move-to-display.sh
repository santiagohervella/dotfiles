#!/bin/bash

source "$(dirname "$0")/target.sh"

target_idx=$1

target_display=$(yabai -m query --displays --display $target_idx)

ww=$(echo "$window" | jq '.frame.w')
wh=$(echo "$window" | jq '.frame.h')

tdx=$(echo "$target_display" | jq '.frame.x')
tdy=$(echo "$target_display" | jq '.frame.y')
tdw=$(echo "$target_display" | jq '.frame.w')
tdh=$(echo "$target_display" | jq '.frame.h')

nx=$(echo "$tdx + ($tdw - $ww) / 2" | bc -l)
ny=$(echo "$tdy + ($tdh - $wh) / 2" | bc -l)

yabai -m window "$id" --move abs:${nx%.*}:${ny%.*}

osascript -e "tell application \"System Events\" to set frontmost of (first process whose unix id is $(echo "$window" | jq '.pid')) to true"
