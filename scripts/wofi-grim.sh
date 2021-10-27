#!/bin/sh

grimshot=/home/anne/Dev/scripts/grimshot.sh
op=$( echo -e " Screen\n Area\n Window\n CopyScreen\n CopyArea\n CopyWindow" | wofi -i --dmenu --conf=/home/anne/.config/wofi/grim  | awk '{print tolower($2)}' )

case $op in 
        screen)
                exec $grimshot --notify save screen
                ;;
        area)
		            exec $grimshot --notify save area
                ;;
        window)
                exec $grimshot --notify save window
                ;;
        copyscreen)
                exec $grimshot --notify copy screen
                ;;
        copyarea)
		            exec $grimshot --notify copy area
                ;;
        copywindow)
                exec $grimshot --notify copy window
                ;;
        
esac

  