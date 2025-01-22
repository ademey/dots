#!/usr/bin/env bash
# This was used to generate json from the config yaml files
# It is not needed now


function tojson() {
  # exit 0
  # filename + ext
  filename=$(basename $1)
  # full path without file
  filepath=$(readlink -f $1 | sed "s|$filename||g")
  # filename extension
  extension=$(echo $filename | awk -F '.' '{print $NF}')
  # filename with no extention
  filebase=$(echo $filename | awk -F '.' '{print $1}')
   
  # echo $filename
  # echo $filepath
  # echo $extension
  echo "Writing: ${filepath}${filebase}.json"

  cat $1 | yq > "${filepath}${filebase}.json"
}

# find ~/dotfiles/waybar/dot-config/waybar/ -name "*.yaml" -exec tojson {} \;
# tojson ~/dotfiles/waybar/dot-config/waybar/configs/float.yml
# find . -name "*.yml" -exec tojson {} \;
find ~/dotfiles/waybar/dot-config/waybar/ -name "*.yml" | while read file; do tojson "$file"; done
# tojson $1
