#!/usr/bin/env bash
# Launch wob - volume OSD
# Called from hyprland exec-once

SOCK="$XDG_RUNTIME_DIR/wob.sock"

# Clean up old socket
rm -f "$SOCK"
mkfifo "$SOCK"

# Start wob reading from socket
tail -f "$SOCK" | wob &
