
#!/usr/bin/env bash

data_home=~/.local/share/nvim/lazy/base46/lua/base46/themes
target_file="${data_home}/$1.lua"


function get_hex() {
    c=$(grep -E "\s$@ = " $target_file | grep -Eo "(#[A-Za-z0-9]+)" | head -n 1)
    echo $c
}

background=$(get_hex "black")
foreground=$(get_hex 'white')
cursor=$(get_hex 'baby_pink')
selection_background=$(get_hex 'sun')
color0=$(get_hex 'daker_black')
color8=$(get_hex 'daker_black')
color1=$(get_hex 'red')
color9=$(get_hex 'red')
color2=$(get_hex 'green')
color10=$(get_hex 'vibrant_green')
color3=$(get_hex 'yellow')
color11=$(get_hex 'yellow')
color4=$(get_hex 'purple')
color12=$(get_hex 'purple')
color5=$(get_hex 'pink')
color13=$(get_hex 'pink')
color6=$(get_hex 'cyan')
color14=$(get_hex 'cyan')
color7=$(get_hex 'grey')
color15=$(get_hex 'grey_fg')
selection_foreground=$(get_hex 'statusline_bg')


echo "
background $background
foreground $foreground
cursor $cursor
selection_background $selection_background
color0 $color0
color8 $color8
color1 $color1
color9 $color9
color2 $color2
color10 $color10
color3 $color3
color11 $color11
color4 $color4
color12 $color12
color5 $color5
color13 $color13
color6 $color6
color14 $color14
color7 $color7
color15 $color15
selection_foreground $selection_foreground
" > ~/.config/kitty/theme.conf
# base00 = "#282936",
# base01 = "#3a3c4e",
# base02 = "#4d4f68",
# base03 = "#626483",
# base04 = "#62d6e8",
# base05 = "#e9e9f4",
# base06 = "#f1f2f8",
# base07 = "#f7f7fb",
# base08 = "#c197fd",
# base09 = "#FFB86C",
# base0A = "#62d6e8",
# base0B = "#F1FA8C",
# base0C = "#8BE9FD",
# base0D = "#50fa7b",
# base0E = "#ff86d3",
# base0F = "#F8F8F2",

echo "done"

