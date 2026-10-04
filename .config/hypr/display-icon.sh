#!/usr/bin/env bash
# Waybar icon: one monitor, or two when another display is connected
if [ "$(hyprctl monitors all -j | jq length)" -gt 1 ]; then
    echo "󰍺"
else
    echo "󰍹"
fi
