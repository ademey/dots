#!/usr/bin/env bash

# https://github.com/dylanaraps/pywal/wiki/Getting-Started#using-a-custom-wallpaper-setter

# TODO: Check that this is an image in wallpaper because of yazi script use
image=$1
op=0
if [ $1 ]; then
    echo "Using file"
    # notify-send "theme" $1
    op=$1
else
    wallpapers="${HOME}/Wallpaper"
    op=$(find $wallpapers -type f | sed -e "s|$wallpapers||" | tofi --prompt-text=" wal: " --config="${HOME}/.config/tofi/fullscreen")
    image="$wallpapers/$op"
fi
# Make an easier way to change these
# op2=$( echo -e "lighten\ndarken" | tofi --prompt-text=" temp: " )
# op3=$( echo -e "1\n2\n3\n4\n5\n6\n7\n8\n9" | tofi --prompt-text=" saturate: " )


# -n skip wallpaper
# -t skip tty
# -e skip reload bar
# -s skip terminals
if [ $op ]; then
    wal -n -t -e -s\
        --saturate 0.5 \
        --cols16 "darken" \
        -p "current" \
        -i $image -o "${HOME}/bin/post-theme.sh"

else
    echo "canceled"
fi
