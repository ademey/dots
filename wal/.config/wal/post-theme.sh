#!/usr/bin/env bash

IMG="$(< "${HOME}/.cache/wal/wal")"

ln -s "${HOME}/.cache/wal/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
# ln -s "${HOME}/.cache/wal/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"

hyprctl hyprpaper preload $IMG
hyprctl hyprpaper wallpaper ", $IMG"

# Generated through pywal templates
# cp "${HOME}/.cache/wal/mako" "${HOME}/.config/mako/config"
# cp "${HOME}/.cache/wal/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
# cp "${HOME}/.cache/wal/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"





makoctl reload
pkill waybar && hyprctl dispatch exec waybar

magick $IMG -blur 0x10 "${HOME}/.cache/hyprlock/background.png"
bash "${home}.config/wal/preview.sh"

## hyprctl keyword general:col.active_border "rgba(FFF000aa)"