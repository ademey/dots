#!/usr/bin/env bash

# Dumb way get the colors from NVChad themes and generate

data_home=~/.local/share/nvim/lazy/base46/lua/base46/themes
theme_name=$1
config_lua=~/.config/nvim/lua/chadrc.lua


if [ -f $config_lua ]; then
    saved_theme=$(grep -Eo "theme = .(\w+)" $config_lua | sed -e 's|theme = "||' | head -n 1)
    # saved_theme=$(grep -Eo "theme = .(\w+)" $config_lua)
    if [ -n $saved_theme ]; then
        theme_name=$saved_theme
        echo "Using stored theme $theme_name"
    fi
fi

target_file="${data_home}/$theme_name.lua"

echo $target_file

if [ ! -f $target_file ]; then
    echo "😿 Theme [$theme_name] not found"
    exit 0
fi

echo "🐱 Setting Kitty theme ($theme_name)"

function get_hex() {
    # TODO: regex could be better
    c=$(grep -E "\s$@ = " $target_file | grep -Eo "(#[A-Za-z0-9]+)" | head -n 1)
    echo $c
}



echo "
background $(get_hex "black")
foreground $(get_hex 'white')
cursor $(get_hex 'baby_pink')
selection_background $(get_hex 'sun')
color0 $(get_hex 'daker_black')
color8 $(get_hex 'daker_black')
color1 $(get_hex 'red')
color9 $(get_hex 'red')
color2 $(get_hex 'green')
color10 $(get_hex 'vibrant_green')
color3 $(get_hex 'yellow')
color11 $(get_hex 'yellow')
color4 $(get_hex 'purple')
color12 $(get_hex 'purple')
color5 $(get_hex 'pink')
color13 $(get_hex 'pink')
color6 $(get_hex 'cyan')
color14 $(get_hex 'cyan')
color7 $(get_hex 'grey')
color15 $(get_hex 'grey_fg')
selection_foreground $(get_hex 'statusline_bg')
" > ~/.config/kitty/theme.conf

kitty @ load-config ~/.config/kitty/kitty.conf

# echo "done"

