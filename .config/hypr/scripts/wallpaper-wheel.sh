#!/usr/bin/env bash

WHEEL_DIR="$HOME/.config/quickshell/wallpaper-wheel"

if pgrep -f "qs -p $WHEEL_DIR" >/dev/null; then
    pkill -f "qs -p $WHEEL_DIR"
    exit 0
fi


qs -p "$WHEEL_DIR"
