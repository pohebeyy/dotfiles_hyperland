#!/usr/bin/env bash
set -e

DOTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config/hypr ~/.config/quickshell ~/Pictures/wallpapers

# Создаём симлинки на конфиги
ln -sf "$DOTS_DIR/.config/hypr/hyprland.lua" ~/.config/hypr/hyprland.lua
[ -f "$DOTS_DIR/.config/hypr/workspaces_bind.conf" ] && ln -sf "$DOTS_DIR/.config/hypr/workspaces_bind.conf" ~/.config/hypr/workspaces_bind.conf
ln -sfn "$DOTS_DIR/.config/hypr/scripts" ~/.config/hypr/scripts
ln -sfn "$DOTS_DIR/.config/quickshell/wallpaper-wheel" ~/.config/quickshell/wallpaper-wheel

chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null || true
echo "Готово! Перезагрузи конфиг: hyprctl reload"
