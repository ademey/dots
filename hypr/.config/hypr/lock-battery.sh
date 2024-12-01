#!/usr/bin/env bash

# @SOURCE: https://github.com/end-4/dots-hyprland/tree/main

############ Variables ############
enable_battery=false
battery_charging=false

####### Check availability ########
for battery in /sys/class/power_supply/*BAT*; do
  if [[ -f "$battery/uevent" ]]; then
    enable_battery=true
    if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
      battery_charging=true
    fi
    break
  fi
done

############# Output #############
if [[ $enable_battery == true ]]; then
  if [[ $battery_charging == true ]]; then
    echo -n "(+) "
  fi
  if [[ $battery_charging == false ]]; then
    echo -n "(-) "
  fi
  echo -n "$(cat /sys/class/power_supply/*/capacity | head -1)"%
fi

echo ''