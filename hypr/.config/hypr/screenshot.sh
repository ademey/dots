#!/bin/sh

op=$( echo -e "Screen\nArea\nWindow\nCopyScreen\nCopyArea\nCopyWindow\nPickColor" | tofi --prompt-text=" capture: "  | awk '{print tolower($1)}' )


case $op in 
        screen)
                exec hyprshot -m output -m active -o "${HOME}/Pictures/screenshots"
                ;;
        area)
		exec hyprshot -m region -o "${HOME}/Pictures/screenshots" -z
                ;;
        window)
                exec hyprshot -m window -o "${HOME}/Pictures/screenshots"
                ;;
        copyscreen)
                exec hyprshot -m output -m active --clipboard-only
                ;;
        copyarea)
		exec hyprshot -m region --clipboard-only -z
                ;;
        copywindow)
                exec hyprshot -m window --clipboard-only
                ;;
        pickcolor)
                exec hyprpicker | wl-copy
                exec notify-send -u low -a "Color" "selected: $(wl-paste)"
                ;;
        
esac

  