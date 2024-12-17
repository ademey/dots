#!/usr/bin/env bash

# woordenboek-van-populair-taalgebruik
# wiktionary
# anw
# scheldwoordenboek
dict="muiswerk"

while getopts ":d:" opt; do
    case $opt in
        d)
            dict=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

search_word=$1
muis_data_home=${XDG_DATA_HOME:-~/.local/share}/muis/${dict}
dict_url="https://www.ensie.nl"
target_file="${muis_data_home}/${search_word}.html"
page_data=""


if [ $1 ]; then
    echo "🐭 Zoeken... ${search_word}"
else
    echo "🐭 Zoekwoord aub..."
    exit 0
fi


if [ ! -d $muis_data_home ]; then
    mkdir -p $muis_data_home
fi

if [ -f $target_file ]; then
    echo "🧀 Laden vanuit cache"
    page_data=$(cat $target_file)
else
    echo "⌛ Bezig met downloaden"
    page_data=$(curl -s $dict_url/$dict/$search_word)
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
    # echo $found | html2md -i | glow -l
else
    echo $default | lynx -dump -stdin
fi


