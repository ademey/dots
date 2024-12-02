#!/usr/bin/env bash

# https://github.com/dylanaraps/pywal/wiki/Getting-Started#using-a-custom-wallpaper-setter

op=$(find ${HOME}/Wallpaper -type f | tofi --prompt-text=" wal: " --config="${HOME}/.config/tofi/fullscreen")
# Make an easier way to change these
# op2=$( echo -e "lighten\ndarken" | tofi --prompt-text=" temp: " )
# op3=$( echo -e "1\n2\n3\n4\n5\n6\n7\n8\n9" | tofi --prompt-text=" saturate: " )

# Need to exit if some selection is skipped

# -n skip wallpaper
# -t skip tty
# -e skip reload bar
wal -n -t -e \
    --saturate 0.5 \
    --cols16 "darken" \
    -i "$op" -o "${HOME}/.config/wal/post-theme.sh"

    