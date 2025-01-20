#!/usr/bin/env bash
##
# Waybar theme selector
#
# Custom theme (color variations) and layout css files are stored
# under .config/waybar/(theme|layout). After selecting with tofi,
# these are copied to a location sourced by further waybar css files.
#
# theme-variant.sh -p bottom -t bench -l wolken -c float

position_option="top"
theme_option="bench"
layout_option="aard"
config_option="default"
use_tofi=false

while getopts 'p:t:l:c:u' opt; do
    case "$opt" in
        p)
            position_option=$OPTARG
            ;;
        t)
            theme_option=$OPTARG
            ;;
        l)
            layout_option=$OPTARG
            ;;
        c)
            config_option=$OPTARG
            ;;
        u)
            use_tofi=true
            ;;
    esac
done

# echo "position $position_option"
# echo "theme $theme_option"
# echo "layout $layout_option"
# echo "tofi? $use_tofi"
# exit 0

# Currently set theme and layout
c_config=$( cat "$HOME/.cache/waybar/config-name" )
c_theme=$( cat "$HOME/.cache/waybar/theme-name" )
c_layout=$( cat "$HOME/.cache/waybar/layout-name" )

function render() {
  cat $@ | tofi --prompt-text=" (xxx) config: "
}
if [[ $use_tofi == true ]]; then
  
position_option=$(printf "top\nbottom\nleft\nright" | tofi --prompt-text=" position: ")
config_option=$( find ~/.config/waybar/configs/*.json | xargs -i{} basename {} | sed 's/.json//' | tofi --prompt-text=" ($_config) config: ")
theme_option=$( find ~/.config/waybar/themes/ -type l,f | xargs -i{} basename {} | sed 's/.css//' | tofi --prompt-text=" ($c_theme) theme: " )
layout_option=$( find ~/.config/waybar/layouts/ -type l,f | xargs -i{} basename {} | sed 's/.css//' | tofi --prompt-text=" ($c_layout) layout: " )
fi


    # Write the selections to cache file
echo $config_option > "$HOME/.cache/waybar/config-name"
echo $theme_option > "$HOME/.cache/waybar/theme-name"
echo $layout_option > "$HOME/.cache/waybar/layout-name"
printf '{ "position": "%s" }' $position_option > "$HOME/.cache/waybar/position.json"
# cp "$HOME/.config/waybar/themes/$op.css" "$HOME/.cache/waybar/theme.css"
unlink ~/.config/waybar/config
ln -s ~/dotfiles/waybar/dot-config/waybar/configs/$config_option.json ~/.config/waybar/config
cp "$HOME/.config/waybar/themes/$theme_option.css" "$HOME/.cache/waybar/theme.css"
cp "$HOME/.config/waybar/layouts/$layout_option.css" "$HOME/.cache/waybar/layout.css"
pkill waybar & hyprctl dispatch exec waybar


