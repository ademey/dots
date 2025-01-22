#!/usr/bin/env bash
# order -> Brightness, Saturation, Hue
brightness=$(gum input --placeholder="Brightness")
saturation=$(gum input --placeholder="Saturation")
hue=$(gum input --placeholder="Hue")

# File with extension
fname=$(echo $1 | xargs -i{} basename {})
# Full path without file
pname=$(realpath $1 | sed -e "s|$fname||")
# File without extensin
bname=$(echo $fname | awk -F '.' '{print $1}')

outfile="${pname}${bname}-shift-${brightness}_${saturation}_${hue}.png"
# echo "$brightness - $saturation - $hue"
# echo $bname
# echo $pname
# echo $outfile

magick $1 -modulate $brightness,$saturation,$hue $outfile
