#!/usr/bin/env bash

c_theme=$( cat "$HOME/.cache/waybar/theme-name" )
c_layout=$( cat "$HOME/.cache/waybar/layout-name" )

op=$( find ~/.dotfiles/waybar/.config/waybar/themes -type f | xargs -I{} basename {} | sed 's/.css//' | tofi --prompt-text=" ($c_theme) theme: " )
op2=$( find ~/.dotfiles/waybar/.config/waybar/layouts -type f | xargs -I{} basename {} | sed 's/.css//' | tofi --prompt-text=" ($c_layout) layout: " )


if [ $op ]; then
    echo $op > "$HOME/.cache/waybar/theme-name"
    echo $op2 > "$HOME/.cache/waybar/layout-name"
    cp "$HOME/.config/waybar/themes/$op.css" "$HOME/.cache/waybar/theme.css"
    cp "$HOME/.config/waybar/layouts/$op2.css" "$HOME/.cache/waybar/layout.css"
    pkill waybar & hyprctl dispatch exec waybar
else
    echo "canceled"
fi

