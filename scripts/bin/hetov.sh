#!/usr/bin/env bash

# https://www.transitchicago.com/developers/ttdocs/#_Toc296199905
#
# pass -c api/cta && export CTA_KEY=$(wl-paste)
hetov_data_home=${XDG_DATA_HOME:-~/.local/share}/hetov

# hetov_data_home=$HOME/.cache/hetov
# settings="$hetov_data_home/settings"
stops_data="$hetov_data_home/stops.json"
arrivals="$hetov_data_home/arrivals.json"
arrivals_dir="$hetov_data_home/arrivals"
history="$hetov_data_home/history.txt"

api_url=http://lapi.transitchicago.com/api/1.0

refresh=1

# Stations have multiple stops
# stop_id="30112" # California
stop_id=""
map_id=""

# echo "$(cat ~/Notes/ascii/cta.ascii)"
echo "🚋 Het OV"
echo "---------"


while getopts 'rls:' opt; do
    case "$opt" in
        s)
            map_id=$OPTARG
            ;;
        r)
            refresh=0
            ;;
        l)
    esac
done

if [ -z "$CTA_KEY" ]; then
    if [ $refresh -eq 1 ]; then
        echo "🗝 API key missing"
        exit 1
    fi
fi


if [ ! -d $hetov_data_home ]; then
    echo "Setting up"
    mkdir -p $hetov_data_home
fi

if [ ! -f $stops_data ]; then
    # https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data
    gum spin --spinner dot --title "📦 Loding "L" database" -- sleep 1 && curl -s "https://data.cityofchicago.org/resource/8pix-ypme.json" > $stops_data


fi


function setup_lines() {
    real_names=("Blue" "Green" "Brown" "Purple" "Purple Exp" "Yellow" "Pink" "Orange")
    codes=("blue" "g" "brn" "p" "pexp" "y" "pnk" "o")

    echo "Red,red" > "$hetov_data_home/lines.csv"
    for i in ${!real_names[@]}; do
        echo "${real_names[$i]},${codes[$i]}" >> "$hetov_data_home/lines.csv"
    done
}


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

function pick_stop() {
    # echo "Select a Line"
    real_names=("Red", "Blue", "Green", "Brown", "Purple", "Purple Exp", "Yellow", "Pink", "Orange")
    codes=("red", "blue", "g", "brn", "p", "pexp", "y", "pnk", "o")
    # awk -F ',' '{printf "%-10s %-4s\n", $1, $2}'
    # line_name=$(cat "$hetov_data_home/lines.csv" | gum choose --header "Line:" --height 10)
    # line_code=$(echo $line_name | awk -F ',' '{print $NF}')

    # echo "Select a Staion"
    # stop_name=$(jq -r ".[] | select(.\"$line_code\" == true) | .stop_name" $stops_data | sort | gum choose --header "Station:" --height 10)
    # stop_name=$(jq -r ".[] | select(.\"$line_code\" == true) | [.map_id, .station_name] | @csv" $stops_data | sort | uniq | gum choose --header "Station:" --height 10)
    stop_name=$(jq -r ".[] | [.map_id, .station_descriptive_name] | @csv" $stops_data | sort | uniq | awk -F "," '{print $2 " " $1}' | sort | sed 's|"||g' | gum filter --placeholder "Station" --value "$(cat $history)" --height 10)
    echo $stop_name > $history
    selected_map_id=$(echo $stop_name | awk -F ' ' '{print $NF}')
    # echo $(jq -r ".[] | select(.map_id == \"$selected_map_id\") | .map_id" $stops_data)
    # echo "> $stop_name > $stop_id"
    echo $selected_map_id
}

# TODO: Get emoji for line color
# function get_color



if [ ! -n "$map_id" ]; then
    setup_lines
    # stop_id=$(pick_stop)
    map_id=$(pick_stop)
fi



if [ ! -n "$map_id" ]; then
    echo "No stop data for stop id: $map_id"
    exit 1
fi


selected_stop=$(jq -c ".[] | select(.map_id == \"$map_id\")" $stops_data | head -n 1)
station_name=$(val "$selected_stop" '.station_descriptive_name')
# map_id=$(val "$selected_stop" '.map_id')


if [ $refresh -eq 1 ]; then
    req="$api_url/ttarrivals.aspx?mapid=$map_id&max=10&outputType=JSON&key=$CTA_KEY"
    # echo "Fetching data: $req"
    gum spin --spinner dot -- sleep 1 && curl -s $req > $arrivals
else
    echo "Using cache"
fi

refresh_time=$(jq -r '.ctatt.tmst' $arrivals)
since_refresh=$(relative $refresh_time)

# echo $(val "$selected_stop" '.blue')

echo ""
printf "%-30s  %8s\n" "$station_name" "$since_refresh"
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
    printf "%-20s %1s %1s %1s %10s\n" "$destNm" "$(flagged $approaching '🚃' ' ')" "$(flagged $delayed '⚠' ' ')" "$(flagged $scheduled '🗓' ' ')" "$(relative $arrT)"

done


exit 0
