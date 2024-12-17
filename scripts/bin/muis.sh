#!/usr/bin/env bash

muis_data_home=${XDG_DATA_HOME:-~/.local/share}/muis
dict="muiswerk"
dict_url="https://www.ensie.nl"
target_file="${muis_data_home}/${1}.html"
page_data=""

if [ $1 ]; then
    echo "🐭 Zoeken... ${1}"
else
    echo "🐭 Zoekwoord aub..."
    exit 0
fi

if [ ! -d $muis_data_home ]; then
    mkdir $muis_data_home
fi

if [ -f $target_file ]; then
    echo "🧀 Laden vanuit cache"
    page_data=$(cat $target_file)
else
    echo "⌛ Bezig met downloaden"
    page_data=$(curl -s $dict_url/$dict/$1)
fi


# Get the main content area and replace any relative urls with the full domain
default=$(echo $page_data | pup '.content' | sed -e 's|href="/|href="http://www.ensie.nl/|')
found=$(echo $default | pup '[itemprop="articleSection"]')
if [ -n "${found}" ]; then
    # Write the data if we found a definition and we didnt already save
    if [ ! -f $target_file ]; then
        echo $page_data > $target_file
    fi

    echo ""
    echo $found | lynx -dump -stdin
else
    echo $default | lynx -dump -stdin
fi


