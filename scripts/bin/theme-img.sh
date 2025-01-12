#!/usr/bin/env bash

if [ -f $1 ]; then
  echo $1 > ${HOME}/.cache/wal/wal
  swww img --transition-type random $1
  magick $1 -blur 0x15 "${HOME}/.cache/hyprlock/background.png"
fi


