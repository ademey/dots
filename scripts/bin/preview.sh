#!/usr/bin/env bash
# TODO: Add cache path if it doesnt exist
 

theme=$(<$HOME/.cache/wal/colors.json)
background=$(echo $theme | jq -r ".special.background")
foreground=$(echo $theme | jq -r ".special.foreground")
cursor=$(echo $theme | jq -r ".special.cursor")
# Needs to handle escapes
image=$(<$HOME/.cache/wal/wal)

color0=$(echo $theme | jq -r ".colors.color0")
color1=$(echo $theme | jq -r ".colors.color1")
color2=$(echo $theme | jq -r ".colors.color2")
color3=$(echo $theme | jq -r ".colors.color3")
color4=$(echo $theme | jq -r ".colors.color4")
color5=$(echo $theme | jq -r ".colors.color5")
color6=$(echo $theme | jq -r ".colors.color6")
color7=$(echo $theme | jq -r ".colors.color7")
color8=$(echo $theme | jq -r ".colors.color8")
color9=$(echo $theme | jq -r ".colors.color9")
color10=$(echo $theme | jq -r ".colors.color10")
color11=$(echo $theme | jq -r ".colors.color11")
color12=$(echo $theme | jq -r ".colors.color12")
color13=$(echo $theme | jq -r ".colors.color13")
color14=$(echo $theme | jq -r ".colors.color14")
color15=$(echo $theme | jq -r ".colors.color15")

magick $image -resize 500 xc:white \
   -fill $color0 -draw "rectangle 0,0 50,50" \
   -fill $color1 -draw "rectangle 50,0 100,50" \
   -fill $color2 -draw "rectangle 100,0 150,50" \
   -fill $color3 -draw "rectangle 150,0 200,50" \
   -fill $color4 -draw "rectangle 200,0 250,50" \
   -fill $color5 -draw "rectangle 250,0 300,50" \
   -fill $color6 -draw "rectangle 300,0 350,50" \
   -fill $color7 -draw "rectangle 350,0 400,50" \
   \
   -fill $color8 -draw "rectangle 0,50 50,100" \
   -fill $color9 -draw "rectangle 50,50 100,100" \
   -fill $color10 -draw "rectangle 100,50 150,100" \
   -fill $color11 -draw "rectangle 150,50 200,100" \
   -fill $color12 -draw "rectangle 200,50 250,100" \
   -fill $color13 -draw "rectangle 250,50 300,100" \
   -fill $color14 -draw "rectangle 300,50 350,100" \
   -fill $color15 -draw "rectangle 350,50 400,100" \
   \
   -fill $background -draw "rectangle 0,100 50,150" \
   -fill $foreground -draw "rectangle 50,100 100,150" \
   -fill $cursor -draw "rectangle 100,100 150,150" \
   $HOME/.cache/wal/images/preview.png
