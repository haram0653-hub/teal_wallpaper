#!/usr/bin/env bash
# Change volume and push the new level to the wob OSD (0 when muted)
# Usage: volume.sh up|down|mute  — used by Hyprland keybinds and waybar

SINK=@DEFAULT_AUDIO_SINK@

case "$1" in
    up)   wpctl set-volume -l 1 "$SINK" 5%+ ;;
    down) wpctl set-volume "$SINK" 5%- ;;
    mute) wpctl set-mute "$SINK" toggle ;;
    *)    echo "usage: $0 up|down|mute" >&2; exit 1 ;;
esac

wpctl get-volume "$SINK" | awk '{print ($3 == "[MUTED]") ? 0 : int($2*100)}' > "$XDG_RUNTIME_DIR/wob.sock"
