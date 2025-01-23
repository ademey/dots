#!/usr/bin/env bash
# order -> Brightness, Saturation, Hue
fname=$(echo $1 | xargs -i{} basename {})
# Full path without file
pname=$(realpath $1 | sed -e "s|$fname||")
# File without extensin
bname=$(echo $fname | awk -F '.' '{print $1}')

outfile="${pname}${bname}-invert.png"
#
# magick $1 -modulate $brightness,$saturation,$hue $(date +"%Y_%m_%d_%I_%M_%S_%p").jpg
magick $1 -channel RGB -negate $outfile
