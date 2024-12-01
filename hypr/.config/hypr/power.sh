#!/usr/bin/env bash

op=$( echo -e "Lock\nLogout\nPoweroff\nReboot\nSuspend" | tofi --prompt-text=" pwr: " | awk '{print tolower($1)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
		hyprlock
                ;;
        logout)
                hyprctl dispatch exit
                ;;
esac