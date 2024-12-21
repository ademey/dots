#!/usr/bin/env bash

# Dumb way get the colors from NVChad themes and generate

theme_name=$1
theme_dir=~/.local/share/nvim/lazy/base46/lua/base46/themes
theme_lua="${theme_dir}/$theme_name.lua"

echo "🐱 Setting Kitty theme ($theme_name)"


if [ ! -f $theme_lua ]; then
    echo "😿 Theme [$theme_name] not found"
    exit 0
fi

function get_hex() {
    # TODO: regex could be better
    c=$(grep -E "\s$@ = " $theme_lua | grep -Eo "(#[A-Za-z0-9]+)" | head -n 1)
    echo $c
}

template_file=~/bin/poes-kitty.tmpl
out_file=~/.config/kitty/theme.conf

export background=$(get_hex "black")
export foreground=$(get_hex 'white')
export cursor=$(get_hex 'baby_pink')
export selection_background=$(get_hex 'sun')
export selection_foreground=$(get_hex 'black')
export color0=$(get_hex 'darker_black')
export color8=$(get_hex 'darker_black')
export color1=$(get_hex 'red')
export color9=$(get_hex 'red')
export color2=$(get_hex 'green')
export color10=$(get_hex 'vibrant_green')
export color3=$(get_hex 'yellow')
export color11=$(get_hex 'yellow')
export color4=$(get_hex 'purple')
export color12=$(get_hex 'purple')
export color5=$(get_hex 'pink')
export color13=$(get_hex 'pink')
export color6=$(get_hex 'cyan')
export color14=$(get_hex 'cyan')
export color7=$(get_hex 'grey')
export color15=$(get_hex 'grey_fg')


# $1: write to file `eval_template 1`
function eval_template() {

    if [ $1 -eq 1 ]; then
        envsubst < $template_file > $out_file
    else
        envsubst < $template_file
    fi
}

eval_template 1

exit 0

echo "
background $(get_hex "black")
foreground $(get_hex 'white')
cursor $(get_hex 'baby_pink')
selection_background $(get_hex 'sun')
selection_foreground $(get_hex 'black')
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
" > ~/.config/kitty/theme.conf

# kitty @ load-config ~/.config/kitty/kitty.conf


# echo "
#
# set -ogq @thm_bg \"$(get_hex 'black')\"
# set -ogq @thm_fg \"$(get_hex 'white')\"
#
# # Colors
# set -ogq @thm_rosewater \"$(get_hex 'baby_pink')\"
# set -ogq @thm_flamingo \"$(get_hex 'pink')\"
# set -ogq @thm_pink \"$(get_hex 'pink')\"
# set -ogq @thm_mauve \"$(get_hex 'dark_purple')\"
# set -ogq @thm_red \"$(get_hex 'red')\"
# set -ogq @thm_maroon \"$(get_hex 'red')\"
# set -ogq @thm_peach \"$(get_hex 'orange')\"
# set -ogq @thm_yellow \"$(get_hex 'sun')\"
# set -ogq @thm_green \"$(get_hex 'green')\"
# set -ogq @thm_teal \"$(get_hex 'teal')\"
# set -ogq @thm_sky \"$(get_hex 'cyan')\"
# set -ogq @thm_sapphire \"$(get_hex 'nord_blue')\"
# set -ogq @thm_blue \"$(get_hex 'blue')\"
# set -ogq @thm_lavender \"$(get_hex 'purple')\"
#
# # Surfaces and overlays
# set -ogq @thm_subtext_1 \"$(get_hex 'light_grey')\"
# set -ogq @thm_subtext_0 \"$(get_hex 'light_grey')\"
# set -ogq @thm_overlay_2 \"$(get_hex 'grey_fg2')\"
# set -ogq @thm_overlay_1 \"$(get_hex 'grey_fg')\"
# set -ogq @thm_overlay_0 \"$(get_hex 'grey')\"
# set -ogq @thm_surface_2 \"$(get_hex 'one_bg3')\"
# set -ogq @thm_surface_1 \"$(get_hex 'one_bg2')\"
# set -ogq @thm_surface_0 \"$(get_hex 'one_bg')\"
# set -ogq @thm_mantle \"$(get_hex 'black2')\"
# set -ogq @thm_crust \"$(get_hex 'black')\"
# " > ~/.config/tmux/plugins/catppuccin/tmux/themes/catppuccin_poes_tmux.conf
#

# echo "done"

