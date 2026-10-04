#!/usr/bin/env bash
# Pick a display layout (extend/duplicate/single screen) with rofi
mons=$(hyprctl monitors all -j)
internal=$(jq -r '[.[] | select(.name | test("^eDP"))][0].name // empty' <<<"$mons")
external=$(jq -r '[.[] | select(.name | test("^eDP") | not)][0].name // empty' <<<"$mons")

if [ -z "$internal" ] || [ -z "$external" ]; then
    notify-send "Display" "No external display connected"
    exit 1
fi

# Keep the external's current mode if it's on (the TV misbehaves with highrr)
ext_mode=$(jq -r --arg n "$external" '.[] | select(.name == $n and (.disabled | not))
    | "\(.width)x\(.height)@\(.refreshRate)"' <<<"$mons")
# Otherwise take its largest ~60Hz mode ("preferred" gives 1366x768 on the TV)
[ -n "$ext_mode" ] || ext_mode=$(jq -r --arg n "$external" '.[] | select(.name == $n) | .availableModes
    | map(capture("^(?<w>\\d+)x(?<h>\\d+)@(?<r>[\\d.]+)") | select((.r | tonumber) | . >= 59 and . <= 61))
    | max_by([(.w | tonumber) * (.h | tonumber), (.r | tonumber)]) // empty | "\(.w)x\(.h)@\(.r)"' <<<"$mons")
ext_mode=${ext_mode:-preferred}

mon() { hyprctl eval "hl.monitor({ $1 })" >/dev/null; }

# Hyprland hides a mirrored output from clients and doesn't re-announce it
# when unmirrored (waybar/hyprpaper never see it), so cycle it off first
unmirror() {
    jq -e --arg n "$1" '.[] | select(.name == $n) | .mirrorOf != "none"' \
        <<<"$(hyprctl monitors all -j)" >/dev/null || return 0
    mon "output = \"$1\", disabled = true"
    sleep 1
}

# Rule that recreates a monitor's current state, used to revert
# (mirrorOf is a monitor id, so map it back to a name)
restore_rule() {
    jq -r --arg n "$1" '(map({key: (.id | tostring), value: .name}) | from_entries) as $names
        | .[] | select(.name == $n) | if .disabled then
        "output = \"\(.name)\", disabled = true"
    else
        "output = \"\(.name)\", disabled = false, mode = \"\(.width)x\(.height)@\(.refreshRate)\", position = \"\(.x)x\(.y)\", scale = \(.scale)"
        + ", mirror = \"\($names[.mirrorOf] // "none")\""
    end' <<<"$mons"
}
revert_int=$(restore_rule "$internal")
revert_ext=$(restore_rule "$external")
# disabled/mirror must be reset explicitly, or they stick from a previous layout
int() { mon "output = \"$internal\", mode = \"highrr\", scale = 1, disabled = false, mirror = \"none\", $1"; }
ext() { [ -n "$2" ] || unmirror "$external"; mon "output = \"$external\", mode = \"$ext_mode\", scale = 1, disabled = false, mirror = \"${2:-none}\", $1"; }

choice=$(printf '%s\n' "Extend right" "Extend left" "Duplicate" "Laptop only" "External only" \
    | rofi -dmenu -i -p "Display")

case "$choice" in
    "Extend right")  int 'position = "0x0"';        ext 'position = "auto-right"' ;;
    "Extend left")   ext 'position = "0x0"';        int 'position = "auto-right"' ;;
    "Duplicate")     int 'position = "0x0"';        ext 'position = "auto"' "$internal" ;;
    "Laptop only")   int 'position = "0x0"';        mon "output = \"$external\", disabled = true" ;;
    "External only") ext 'position = "0x0"';        mon "output = \"$internal\", disabled = true" ;;
    *) exit 0 ;;
esac

# Revert unless confirmed, so a blank screen fixes itself
sleep 2
keep=$(printf '%s\n' "Keep" "Revert" | timeout 15 rofi -dmenu -i -p "Keep this layout? (reverts in 15s)")
if [ "$keep" != "Keep" ]; then
    # Enable first so there's never zero active outputs
    case "$revert_ext" in *'mirror = "none"'*) unmirror "$external" ;; esac
    case "$revert_int" in *disabled*) mon "$revert_ext"; mon "$revert_int" ;;
                          *)          mon "$revert_int"; mon "$revert_ext" ;; esac
    notify-send "Display" "Layout reverted"
fi

# Layer surfaces keep their old coordinates when an output moves, so the bar
# and wallpaper end up on the wrong screen; restart them on the new layout
pkill -x waybar; pkill -x hyprpaper
sleep 0.5
setsid -f hyprpaper >/dev/null 2>&1
setsid -f waybar >/dev/null 2>&1
