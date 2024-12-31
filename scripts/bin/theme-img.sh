#!/usr/bin/env bash

if [ -f $1 ]; then
  swww img --transition-type random $1
  magick $1 -blur 0x15 "${HOME}/.cache/hyprlock/background.png"
fi


