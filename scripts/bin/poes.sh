#!/usr/bin/env bash

# Dumb way get the colors from NVChad themes and generate

data_home=~/.local/share/nvim/lazy/base46/lua/base46/themes
theme_name=$1
config_lua=~/.config/nvim/lua/chadrc.lua


target_file="${data_home}/$theme_name.lua"
target_data=""

echo "🐱 Setting Kitty theme ($theme_name)"

if [ -f $target_file ]; then
    echo "Setting direct theme"
else
    if [ -f $config_lua ]; then
        # This isnt working with -
        saved_theme=$(grep -Eo "theme = .(\w+)(-\w+)" $config_lua | sed -e 's|theme = "||' | head -n 1)
        # saved_theme=$(grep -Eo "theme = .(\w+)" $config_lua)
        if [ -n $saved_theme ]; then
            theme_name=$saved_theme
            target_file="${data_home}/$theme_name.lua"
            echo "Using stored theme $theme_name"
        fi

    fi
fi


if [ ! -f $target_file ]; then
    echo "😿 Theme [$theme_name] not found"
    exit 0
fi

target_data=$(cat $target_file)

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
color0 $(get_hex 'darker_black')
color8 $(get_hex 'darker_black')
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
selection_foreground $(get_hex 'black')
" > ~/.config/kitty/theme.conf

echo "

set -ogq @thm_bg \"$(get_hex 'black')\"
set -ogq @thm_fg \"$(get_hex 'white')\"

# Colors
set -ogq @thm_rosewater \"$(get_hex 'baby_pink')\"
set -ogq @thm_flamingo \"$(get_hex 'pink')\"
set -ogq @thm_pink \"$(get_hex 'pink')\"
set -ogq @thm_mauve \"$(get_hex 'dark_purple')\"
set -ogq @thm_red \"$(get_hex 'red')\"
set -ogq @thm_maroon \"$(get_hex 'red')\"
set -ogq @thm_peach \"$(get_hex 'orange')\"
set -ogq @thm_yellow \"$(get_hex 'sun')\"
set -ogq @thm_green \"$(get_hex 'green')\"
set -ogq @thm_teal \"$(get_hex 'teal')\"
set -ogq @thm_sky \"$(get_hex 'cyan')\"
set -ogq @thm_sapphire \"$(get_hex 'nord_blue')\"
set -ogq @thm_blue \"$(get_hex 'blue')\"
set -ogq @thm_lavender \"$(get_hex 'purple')\"

# Surfaces and overlays
set -ogq @thm_subtext_1 \"$(get_hex 'light_grey')\"
set -ogq @thm_subtext_0 \"$(get_hex 'light_grey')\"
set -ogq @thm_overlay_2 \"$(get_hex 'grey_fg2')\"
set -ogq @thm_overlay_1 \"$(get_hex 'grey_fg')\"
set -ogq @thm_overlay_0 \"$(get_hex 'grey')\"
set -ogq @thm_surface_2 \"$(get_hex 'one_bg3')\"
set -ogq @thm_surface_1 \"$(get_hex 'one_bg2')\"
set -ogq @thm_surface_0 \"$(get_hex 'one_bg')\"
set -ogq @thm_mantle \"$(get_hex 'black2')\"
set -ogq @thm_crust \"$(get_hex 'black')\"
" > ~/.config/tmux/plugins/catppuccin/tmux/themes/catppuccin_poes_tmux.conf

# kitty @ load-config ~/.config/kitty/kitty.conf

# echo "done"

