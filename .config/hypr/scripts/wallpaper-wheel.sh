#!/usr/bin/env bash

WHEEL_DIR="$HOME/.config/quickshell/wallpaper-wheel"

if pgrep -f "qs -p $WHEEL_DIR" >/dev/null; then
    pkill -f "qs -p $WHEEL_DIR"
    exit 0
fi

if ! pgrep -x "awww-daemon" >/dev/null; then
    awww-daemon >/dev/null 2>&1 &
    sleep 0.3
fi

qs -p "$WHEEL_DIR"
