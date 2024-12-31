#!/usr/bin/env bash
##
# Waybar theme selector
#
# Custom theme (color variations) and layout css files are stored
# under .config/waybar/(theme|layout). After selecting with tofi,
# these are copied to a location sourced by further waybar css files.
#

# Currently set theme and layout
c_theme=$( cat "$HOME/.cache/waybar/theme-name" )
c_layout=$( cat "$HOME/.cache/waybar/layout-name" )

op=$( find ~/.config/waybar/themes -type f | xargs -i{} basename {} | sed 's/.css//' | tofi --prompt-text=" ($c_theme) theme: " )
op2=$( find ~/.config/waybar/layouts -type f | xargs -i{} basename {} | sed 's/.css//' | tofi --prompt-text=" ($c_layout) layout: " )


if [ $op ]; then
    # Write the selections to cache file
    echo $op > "$HOME/.cache/waybar/theme-name"
    echo $op2 > "$HOME/.cache/waybar/layout-name"

    cp "$HOME/.config/waybar/themes/$op.css" "$HOME/.cache/waybar/theme.css"
    cp "$HOME/.config/waybar/layouts/$op2.css" "$HOME/.cache/waybar/layout.css"
    pkill waybar & hyprctl dispatch exec waybar
else
    echo "canceled"
fi

