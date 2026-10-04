#!/usr/bin/env bash
# Pick an audio output (card profile) with rofi
card=$(pactl -f json list cards | jq -r '.[0].name')

choice=$(pactl -f json list cards | jq -r '
  .[0].profiles | to_entries[]
  | select(.value.available and .value.sinks > 0 and (.key | test("input:")))
  | "\(.value.description)\t\(.key)"' \
  | rofi -dmenu -i -p "Output" -display-columns 1 -display-column-separator '\t')

[ -n "$choice" ] && pactl set-card-profile "$card" "${choice##*$'\t'}"
