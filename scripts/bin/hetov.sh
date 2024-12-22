#!/usr/bin/env bash

# https://www.transitchicago.com/developers/ttdocs/#_Toc296199905
#
# export CTA_KEY=$(pass api/cta | head -n 1)
tmp_dir=$HOME/.cache/hetov
stops_data="$tmp_dir/stops.json"
arrivals="$tmp_dir/arrivals.json"

api_url=http://lapi.transitchicago.com/api/1.0

refresh=0

station="40570" # California
stop_id="30112"


# echo "$(cat ~/Notes/ascii/cta.ascii)"
echo "🚋🚇 Het OV"

if [ -z "$CTA_KEY" ]; then
    echo "🗝 API key missing"
    exit 1
fi

while getopts 'rs:' opt; do
    case "$opt" in
        s)
            station=$OPTARG
            ;;
        r)
            refresh=1
            ;;
    esac
done

if [ ! -f $stops_data ]; then
    echo '📦 Loding "L" database'
    curl -s "https://data.cityofchicago.org/resource/8pix-ypme.json" > $stops_data
fi


# base_url=http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=$CTA_KEY

# data=$(jq -c '.ctatt.eta[] | { staNm, destNm, prdt }' "$tmp_dir/arrivals.json")

# echo $(ascii-image-converter ~/Pictures/cta.png -C -b --dither --threshold 150 -W 20)

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

station_name=$(val "$selected_stop" '.station_name')
station_id=$(val "$selected_stop" '.map_id')


if [ $refresh -eq 1 ]; then
    req="$api_url/ttarrivals.aspx?mapid=$station_id&max=5&outputType=JSON&key=$CTA_KEY"
    echo "Fetching data: $req"
    curl -s $req > $arrivals
fi

refresh_time=$(jq -r '.ctatt.tmst' $arrivals)
since_refresh=$(relative $refresh_time)

echo ""
# echo "$station_name             ($since_refresh)"
printf "%-25s -- %15s\n" "$station_name" "$since_refresh"
echo "------------------------------------------"


# function status

cat "$arrivals" | jq -c '.ctatt.eta[]' | while IFS= read -r item; do
    # Extract individual properties from each item
    staNm=$(val "$item" '.staNm')
    destNm=$(val "$item" '.destNm')
    prdt=$(val "$item" '.prdt')
    arrT=$(val "$item" '.arrT')

    approaching=$(val "$item" '.isApp')
    scheduled=$(val "$item" '.isSch')
    delayed=$(val "$item" '.isDly')
    fault=$(val "$item" '.isFlt')
    # printf "app: %-1s" "$(flagged $approaching '🚇' ' ')"
    # Convert the original datetime to CST (America/Chicago) and append the time zone
    printf "%-25s %-8s %-1s %-1s %-1s\n" "$destNm" "$(relative $arrT)" "$(flagged $approaching '🔜' '.')" "$(flagged $delayed '⚠' '.')" "$(flagged $scheduled '🗓' '.')"
    # echo "$destNm: $(prettytime $arrT) []"

    # echo "$item"
done


exit 0
# if [ $1 -eq 'arrivals' ]; then
#     req="$api_url/ttarrivals.aspx?mapid=40570&max=5&outputType=JSON&key=$CTA_KEY"
#     curl $req > "$tmp_dir/arrivals.json"
#     jq -r '.ctatt.eta[] | { staNm, destNm, prdt }' "$tmp_dir/arrivals.json"
# fi
# if [ $1 == 'positions' ]; then
#     req="$api_url/ttpositions.aspx?rt=blue&outputType=JSON&key=$CTA_KEY"
#     curl $req > "$tmp_dir/positions.json"
#     # jq -r '.ctatt' "$tmp_dir/positions.json"
# fi
# data=$(cat "$tmp_dir/response.json")

# echo $data > "$tmp_dir/response.json"
#


