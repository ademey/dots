#!/usr/bin/env bash

# https://www.transitchicago.com/developers/ttdocs/#_Toc296199905
#
# export CTA_KEY=$(pass api/cta | head -n 1)
tmp_dir=$HOME/.cache/hetov
settings="$tmp_dir/settings"
stops_data="$tmp_dir/stops.json"
arrivals="$tmp_dir/arrivals.json"

api_url=http://lapi.transitchicago.com/api/1.0

refresh=0

# Stations have multiple stops
# station="40570" # California
# stop_id="30112"
stop_id=""
map_id=""

# echo "$(cat ~/Notes/ascii/cta.ascii)"
echo "🚋🚇 Het OV"

if [ -z "$CTA_KEY" ]; then
    echo "🗝 API key missing"
    exit 1
fi

while getopts 'rls:' opt; do
    case "$opt" in
        s)
            stop_id=$OPTARG
            ;;
        r)
            refresh=1
            ;;
        l)
    esac
done

if [ ! -f $stops_data ]; then
    echo '📦 Loding "L" database'
    # https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data
    curl -s "https://data.cityofchicago.org/resource/8pix-ypme.json" > $stops_data
fi

if [ ! -n "$stop_id" ]; then
    # echo "Select a Line"
    line_name=$(gum choose --header "Line:" --height 15 "red" "blue" "g" "brn" "p" "pexp" "y" "pnk" "o")

    # echo "Select a Staion"
    stop_name=$(jq -r ".[] | select(.\"$line_name\" == true) | .stop_name" $stops_data | sort | gum choose --header "Station:" --height 15)
    stop_id=$(jq -r ".[] | select(.stop_name == \"$stop_name\") | .stop_id" $stops_data)
    echo "> $stop_name > $stop_id"
fi


function relative() {
    local last_unix="$(date --date="$1" +%s)"    # convert date to unix timestamp
    local now_unix="$(date +'%s')"

    local delta=$(( $last_unix - $now_unix ))

    if (( $delta < 60 ))
    then
        echo "$delta sec"
        return
    elif ((delta < 2700))  # 45 * 60
    then
        echo "$(( $delta / 60 )) min";
    fi
}

# $1 jq object string
# $2 jq selector
function val() {
    echo $1 | jq -r $2
}

# $1 0 or 1 value
# $2 output of true
# $3 output of false
function flagged() {
    if [ "$1" -eq "1" ]; then
        echo "$2"
    else
        echo "$3"
    fi
}

selected_stop=$(jq -r ".[] | select(.stop_id == \"$stop_id\")" $stops_data)

if [ ! -n "$selected_stop" ]; then
    echo "No stop data for stop id: $stop_id"
    exit 1
fi

station_name=$(val "$selected_stop" '.station_descriptive_name')
map_id=$(val "$selected_stop" '.map_id')


if [ $refresh -eq 1 ]; then
    req="$api_url/ttarrivals.aspx?mapid=$map_id&max=10&outputType=JSON&key=$CTA_KEY"
    # echo "Fetching data: $req"
    curl -s $req > $arrivals
fi

refresh_time=$(jq -r '.ctatt.tmst' $arrivals)
since_refresh=$(relative $refresh_time)

# echo $(val "$selected_stop" '.blue')

echo ""
printf "%-25s -- %15s\n" "$station_name" "$since_refresh"
echo "------------------------------------------"




cat "$arrivals" | jq -c '.ctatt | .eta[]' | while IFS= read -r item; do
    # Extract individual properties from each item
    staNm=$(val "$item" '.staNm')
    destNm=$(val "$item" '.destNm')
    prdt=$(val "$item" '.prdt')
    arrT=$(val "$item" '.arrT')

    approaching=$(val "$item" '.isApp')
    scheduled=$(val "$item" '.isSch')
    delayed=$(val "$item" '.isDly')
    fault=$(val "$item" '.isFlt')
    printf "%-25s %-8s %-1s %-1s %-1s\n" "$destNm" "$(relative $arrT)" "$(flagged $approaching '🔜' '.')" "$(flagged $delayed '⚠' '.')" "$(flagged $scheduled '🗓' '.')"

done


exit 0
