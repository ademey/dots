#!/usr/bin/env bash
##
# Waybar theme selector
#
# Custom theme (color variations) and layout css files are stored
# under .config/waybar/(theme|layout). After selecting with tofi,
# these are copied to a location sourced by further waybar css files.
#

# Currently set theme and layout
c_config=$( cat "$HOME/.cache/waybar/config-name" )
c_theme=$( cat "$HOME/.cache/waybar/theme-name" )
c_layout=$( cat "$HOME/.cache/waybar/layout-name" )

pos=$(printf "top\nbottom\nleft\nright" | tofi --prompt-text=" position: ")
op=$( find ~/.config/waybar/configs/ -type l,f | xargs -i{} basename {} | tofi --prompt-text=" ($c_config) config: " )
op2=$( find ~/.config/waybar/themes/ -type l,f | xargs -i{} basename {} | sed 's/.css//' | tofi --prompt-text=" ($c_theme) theme: " )
op3=$( find ~/.config/waybar/layouts/ -type l,f | xargs -i{} basename {} | sed 's/.css//' | tofi --prompt-text=" ($c_layout) layout: " )


if [ $op ]; then
    # Write the selections to cache file
    echo $op > "$HOME/.cache/waybar/config-name"
    echo $op2 > "$HOME/.cache/waybar/theme-name"
    echo $op3 > "$HOME/.cache/waybar/layout-name"
    printf '{ "position": "%s" }' $pos > "$HOME/.cache/waybar/position.json"
    # cp "$HOME/.config/waybar/themes/$op.css" "$HOME/.cache/waybar/theme.css"
    unlink ~/.config/waybar/config
    ln -s ~/dotfiles/waybar/dot-config/waybar/configs/$op ~/.config/waybar/config
    cp "$HOME/.config/waybar/themes/$op2.css" "$HOME/.cache/waybar/theme.css"
    cp "$HOME/.config/waybar/layouts/$op3.css" "$HOME/.cache/waybar/layout.css"
    pkill waybar & hyprctl dispatch exec waybar

   else
    echo "canceled"
fi

