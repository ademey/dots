#!/usr/bin/env bash

# https://github.com/dylanaraps/pywal/wiki/Getting-Started#using-a-custom-wallpaper-setter

wallpapers="${HOME}/Wallpaper"
op=$(find $wallpapers -type f | sed -e "s|$wallpapers||" | tofi --prompt-text=" wal: " --config="${HOME}/.config/tofi/fullscreen")
# Make an easier way to change these
# op2=$( echo -e "lighten\ndarken" | tofi --prompt-text=" temp: " )
# op3=$( echo -e "1\n2\n3\n4\n5\n6\n7\n8\n9" | tofi --prompt-text=" saturate: " )


# -n skip wallpaper
# -t skip tty
# -e skip reload bar
if [ $op ]; then
  wal -n -t -e \
    --saturate 0.5 \
    --cols16 "darken" \
    -i "$wallpapers/$op" -o "${HOME}/.config/wal/post-theme.sh"

else
    echo "canceled"
fi   
