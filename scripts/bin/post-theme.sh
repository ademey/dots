#!/usr/bin/env bash

IMG="$(< "${HOME}/.cache/wal/wal")"

# Generated through pywal templates
ln -s "${HOME}/.cache/wal/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
ln -s "${HOME}/.cache/wal/mako" "${HOME}/.config/mako/config"
# Maybe link later, right now it is fine with whatever as default
# ln -s "${HOME}/.cache/wal/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"

hyprctl hyprpaper preload $IMG
hyprctl hyprpaper wallpaper ", $IMG"

pkill waybar && hyprctl dispatch exec waybar
makoctl reload

# Would be cool to do other effects
magick $IMG -blur 0x10 "${HOME}/.cache/hyprlock/background.png"
bash "${HOME}/.config/wal/preview.sh"

## hyprctl keyword general:col.active_border "rgba(FFF000aa)"