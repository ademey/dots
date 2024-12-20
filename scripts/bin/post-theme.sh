#!/usr/bin/env bash

IMG="$(< "${HOME}/.cache/wal/wal")"

# Generated through pywal templates
ln -s "${HOME}/.cache/wal/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
ln -s "${HOME}/.cache/wal/mako" "${HOME}/.config/mako/config"
# Not using this right now
# ln -s "${HOME}/.cache/wal/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"

# hyprctl hyprpaper preload $IMG
# hyprctl hyprpaper wallpaper ", $IMG"

swww img --transition-type random $IMG
pkill waybar && hyprctl dispatch exec waybar
makoctl reload

# Would be cool to do other effects
magick $IMG -blur 0x15 "${HOME}/.cache/hyprlock/background.png"

# Generates an image with the background and colors
# bash "${HOME}/.config/wal/preview.sh"

