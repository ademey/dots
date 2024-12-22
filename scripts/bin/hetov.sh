#!/usr/bin/env bash

# https://www.transitchicago.com/developers/ttdocs/#_Toc296199905
#
# export CTA_KEY=$(pass api/cta | head -n 1)
tmp_dir=$HOME/.cache/hetov
in_data=~/cta.json
key=$CTA_KEY
refresh=0

station="40590" # Damen
station="40570" # California

# echo "$(cat ~/Notes/ascii/cta.ascii)"
echo "🚋 Het OV"

if [ -z "$CTA_KEY" ]; then
    echo "API key missing"
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


api_url=http://lapi.transitchicago.com/api/1.0
# base_url=http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=$CTA_KEY

if [ $refresh -eq 1 ]; then
    echo "Fetching data"
    req="$api_url/ttarrivals.aspx?mapid=40590&max=5&outputType=JSON&key=$CTA_KEY"
    curl -s $req > "$tmp_dir/arrivals.json"
fi
# data=$(jq -c '.ctatt.eta[] | { staNm, destNm, prdt }' "$tmp_dir/arrivals.json")

# echo $(ascii-image-converter ~/Pictures/cta.png -C -b --dither --threshold 150 -W 20)
echo ""
jq -c '.ctatt.eta[0].staNm' "$tmp_dir/arrivals.json"


function prettytime() {


    # Your CST datetime string
    cst_date=$(TZ="America/Chicago" date -d "$1" +"%Y-%m-%dT%H:%M:%S CST")

    # Get the current date and time in the same time zone (CST)
    now=$(TZ="America/Chicago" date +"%Y-%m-%dT%H:%M:%S")
    if [ -n "$2" ]; then
        echo "using provided $2"
        now=$(TZ="America/Chicago" date -d "$2" +"%Y-%m-%dT%H:%M:%S CST")
    fi
    # Convert both dates to Unix timestamps
    cst_timestamp=$(TZ="America/Chicago" date -d "$1" +%s)
    now_timestamp=$(TZ="America/Chicago" date +%s)

    # Calculate the difference in seconds
    time_diff=$((cst_timestamp - now_timestamp))

    # Determine the relative time (past or future)
    if ((time_diff == 0)); then
        echo "Just now"
    elif ((time_diff < 0)); then
        time_diff=$(( -time_diff ))  # Make the time difference positive for past cases
        if ((time_diff < 60)); then
            echo "$time_diff seconds ago"
        elif ((time_diff < 3600)); then
            minutes=$((time_diff / 60))
            echo "$minutes minutes ago"
        elif ((time_diff < 86400)); then
            hours=$((time_diff / 3600))
            echo "$hours hours ago"
        elif ((time_diff < 2592000)); then
            days=$((time_diff / 86400))
            echo "$days days ago"
        else
            months=$((time_diff / 2592000))
            echo "$months months ago"
        fi
    else
        # If the time difference is positive, it is in the future
        if ((time_diff < 60)); then
            echo "$time_diff seconds from now"
        elif ((time_diff < 3600)); then
            minutes=$((time_diff / 60))
            echo "$minutes minutes from now"
        elif ((time_diff < 86400)); then
            hours=$((time_diff / 3600))
            echo "$hours hours from now"
        elif ((time_diff < 2592000)); then
            days=$((time_diff / 86400))
            echo "$days days from now"
        else
            months=$((time_diff / 2592000))
            echo "$months months from now"
        fi
    fi
}



cat "$tmp_dir/arrivals.json" | jq -c '.ctatt.eta[]' | while IFS= read -r item; do
    # Extract individual properties from each item
    staNm=$(echo "$item" | jq -r '.staNm')
    destNm=$(echo "$item" | jq -r '.destNm')
    prdt=$(echo "$item" | jq -r '.prdt')
    arrT=$(echo "$item" | jq -r '.arrT')

    # Convert the original datetime to CST (America/Chicago) and append the time zone

    echo "$destNm: $(prettytime $arrT)"
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


