#!/usr/bin/env bash

# Run after setting pywal theme

# Load the image name last used by pywal
image="$(< "${HOME}/.cache/wal/wal")"
# Or provide an image path
if [ $1 ]; then
  image=$1
fi

# Generated through pywal templates
ln -s "${HOME}/.cache/wal/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
ln -s "${HOME}/.cache/wal/mako" "${HOME}/.config/mako/config"


# Hyprpaper
# ln -s "${HOME}/.cache/wal/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"
# hyprctl hyprpaper preload $IMG
# hyprctl hyprpaper wallpaper ", $IMG"

swww img --transition-type random $image
pkill waybar && hyprctl dispatch exec waybar

# Would be cool to do other effects
magick $image -blur 0x15 "${HOME}/.cache/hyprlock/background.png"
makoctl reload
# Generates an image with the background and colors
bash "${HOME}/bin/preview.sh"

