#!/usr/bin/env bash
# Launch wob - volume OSD
# Called from hyprland exec-once

SOCK="$XDG_RUNTIME_DIR/wob.sock"

# Stop any previous instance (e.g. after a config reload)
pkill -x wob
pkill -f "tail -f $SOCK"

# Clean up old socket
rm -f "$SOCK"
mkfifo "$SOCK"

# Start wob reading from socket
tail -f "$SOCK" | wob &
