#!/usr/bin/env bash

# TODO: Fallback for no results
dict="muiswerk"
dict_url="https://www.ensie.nl"
if [ $1 ]; then
  data=$(curl -s $dict_url/$dict/$1)
  # Get the main content area and replace any relative urls with the full domain
  default=$(echo $data | pup '.content' | sed -e 's|href="/|href="http://www.ensie.nl/|')
  found=$(echo $default | pup '[itemprop="articleSection"]')
  if [ -n "${found}" ]; then
    # search=$(echo $data | pup '[itemprop="articleSection"]' | sed -e 's|href="/|href="http://www.ensie.nl/|')
    echo $found | lynx -dump -stdin
  else
    echo $default | lynx -dump -stdin
  fi
else
  echo "Een zoekwoord aub"
fi


