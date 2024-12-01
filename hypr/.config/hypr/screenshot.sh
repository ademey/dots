#!/bin/sh

op=$( echo -e "Screen\nArea\nWindow\nCopyScreen\nCopyArea\nCopyWindow\nPickColor" | tofi --prompt-text=" capture: "  | awk '{print tolower($1)}' )


case $op in 
        screen)
                exec hyprshot -m output -m active -o $XDG_SCREENSHOTS_DIR
                ;;
        area)
		exec hyprshot -m region -o $XDG_SCREENSHOTS_DIR
                ;;
        window)
                exec hyprshot -m window -o $XDG_SCREENSHOTS_DIR
                ;;
        copyscreen)
                exec hyprshot -m output -m active --clipboard-only
                ;;
        copyarea)
		exec hyprshot -m region --clipboard-only
                ;;
        copywindow)
                exec hyprshot -m window --clipboard-only
                ;;
        pickcolor)
                exec hyprpicker | wl-copy
                exec notify-send -u low -a "Color" "selected: $(wl-paste)"
                ;;
        
esac

  