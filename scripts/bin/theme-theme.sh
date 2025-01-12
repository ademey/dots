#!/usr/bin/env bash
##
# Waybar theme selector
#
# Custom theme (color variations) and layout css files are stored
# under .config/waybar/(theme|layout). After selecting with tofi,
# these are copied to a location sourced by further waybar css files.
#

c_config=$( cat "$HOME/.cache/waybar/wal-theme-name" )
opt_file=$HOME/.cache/wal/theme-options.yml
# The output has colors, so this tries to remove those scpecial chacters
wal --theme | sed -e $'s/\x1b\[[0-9;]*m//g' > $opt_file

# TODO: This will screw up if you cancel the first selection
theme_type=$(echo "Dark,Light,User" | tr ',' '\n' | tofi --prompt-text=" theme type ")
user_theme=$(yq -r --arg 'thm' $theme_type 'to_entries[] | select(.key | startswith($thm)) | .value | @csv' $opt_file | tr ',' '\n' | sed 's/"//g' | tofi --prompt-text=" theme ($c_config): " --config="${HOME}/.config/tofi/fullscreen")

if [ $user_theme ]; then
    if [ "$theme_type" == "Light" ]; then
      wal --theme $user_theme -l -o ~/bin/theme-post.sh
    else
      wal --theme $user_theme -o ~/bin/theme-post.sh
    fi
    echo $user_theme > "$HOME/.cache/waybar/wal-theme-name"
else
    echo "canceled"
fi

