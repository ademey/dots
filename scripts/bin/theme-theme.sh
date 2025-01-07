#!/usr/bin/env bash
##
# Waybar theme selector
#
# Custom theme (color variations) and layout css files are stored
# under .config/waybar/(theme|layout). After selecting with tofi,
# these are copied to a location sourced by further waybar css files.
#


op=$( wal --theme | grep "^ - " | awk '{print $2}' | tofi --prompt-text=" colors: " --config="${HOME}/.config/tofi/fullscreen")


if [ $op ]; then
    wal --theme $op -o ~/bin/theme-post.sh
    # Write the selections to cache file
    # pkill waybar & hyprctl dispatch exec waybar
else
    echo "canceled"
fi

