#!/usr/bin/env bash

# https://www.transitchicago.com/developers/ttdocs/#_Toc296199905
#
# pass -c api/cta && export CTA_KEY=$(wl-paste)
hetov_data_home=${XDG_DATA_HOME:-~/.local/share}/hetov

# hetov_data_home=$HOME/.cache/hetov
# settings="$hetov_data_home/settings"
bus_routes_data="$hetov_data_home/bus-routes.json"
bus_prediction_data="$hetov_data_home/bus-prediction.json"
# Each routes stops get stored here when first requested
# Also it's directional info is saved as a separate file
routes_dir="$hetov_data_home/routes"
# Each prediction request gets saved by it's stop id 
stops_dir="$hetov_data_home/bus-stops"

# routes_endpoint=http://lapi.transitchicago.com/api/1.0
# curl "http://www.ctabustracker.com/bustime/api/v2/getroutes?key=$BUS_KEY&format=json" > routes.json
routes_endpoint="http://www.ctabustracker.com/bustime/api/v2/getroutes?key=$BUS_KEY&format=json"
stops_endpoint="http://www.ctabustracker.com/bustime/api/v2/getstops?key=$BUS_KEY&format=json"
directions_endpoint="http://www.ctabustracker.com/bustime/api/v2/getdirections?key=$BUS_KEY&format=json"
predictions_endpoint="http://www.ctabustracker.com/bustime/api/v2/getpredictions?key=$BUS_KEY&format=json"
refresh=1
loop=0

# Stations have multiple stops
# stop_id="30112" # California
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
            loop=1
            ;;
    esac
done

if [ -z "$BUS_KEY" ]; then
    echo "🔒 API key missing"
    exit 1
fi


if [ ! -d $hetov_data_home ]; then
    echo "Setting up"
    mkdir -p $hetov_data_home
fi

if [ ! -d $routes_dir ]; then
    mkdir -p $routes_dir
fi

if [ ! -d $stops_dir ]; then
    mkdir -p $stops_dir
fi

if [ ! -f $bus_routes_data ]; then
    # https://d
    # ata.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data
    gum spin --spinner dot --title "📦 Loding routes data" -- sleep 1 && curl -s $routes_endpoint > $bus_routes_data
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

function selectroute() {
    local selected_line=$(jq -r '."bustime-response".routes[] | [.rt, .rtnm] | @csv' $bus_routes_data | sed 's|"||g' | sed 's|,| |' | gum filter --placeholder "Bus Line" --height 10)
    local route_num=$(echo $selected_line | awk -F ' ' '{print $1}')
    echo $route_num
}

function selectdir() {
    local dir_file="$routes_dir/$1-dir.json"
    # ata.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data
    if [ ! -f $dir_file ]; then
        gum spin --spinner dot --title "Getting directions for $1" -- sleep 1 && curl -s "$directions_endpoint&rt=$1" > $dir_file
    fi
    cat $dir_file | jq -r '."bustime-response".directions[].dir' | gum choose
}

function selectstop() {
    if [ ! -f "$routes_dir/$1-$2.json" ]; then
        # ata.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data
        gum spin --spinner dot --title "Getting stops for $1" -- sleep 1 && curl -s "$stops_endpoint&rt=$1&dir=$2" > "$routes_dir/$1-$2.json"
    fi
    local stop_name=$(jq -r '."bustime-response".stops[] | [.stpnm, .stpid] | @csv' "$routes_dir/$1-$2.json" | sed 's|"||g' | sed 's|,| |g' | gum filter --height 15)
    local stop_id=$(echo $stop_name | awk -F ' ' '{print $NF}')
    echo $stop_id
}

function getpredictions() {

    local $selected_stop=$(gum spin --spinner dot --title "Loading preditions" -- sleep 1 && curl -s "$predictions_endpoint&stpid=$1" > $bus_prediction_data)
    # local stop_id=$(echo $selected_stop | awk -F ' ' '{print $1}')
}

function render() {
    local stop_data=$(jq --arg "stpid" $route_stop '."bustime-response".stops[] | select(.stpid == $stpid )' "$routes_dir/$route_num-$route_direction.json")
    clear
    local stop_name=$(val "$stop_data" ".stpnm")
    # local prediction_file="$stops_dir/$route_num-$route_stop.json"
    local prediction_file=$bus_prediction_data
    printf "%-30s  %10s\n" "$stop_name" "$route_direction"
    echo "------------------------------------------"

    cat $prediction_file | jq -c '."bustime-response".prd[]' | while IFS= read -r item; do
        # Extract individual properties from each item
        tmstmp=$(val "$item" '.tmstmp')
        des=$(val "$item" '.des') # Destination
        rt=$(val "$item" '.rt') # Route
        prdctdn=$(val "$item" '.prdctdn') # Predicted time to arriaval (minutes)
        vid=$(val "$item" '.vid') # Bus ID
        if [ "$prdctdn" == "DUE" ]; then

          printf "(%2d) %-2333%4s (%4d)\n" "$rt" "$des" "$prdctdn" "$vid"
        else
          printf "(%2d) %-23s %2d min (%4d)\n" "$rt" "$des" "$prdctdn" "$vid"
        fi

    done
}




route_num=$(selectroute)
echo "> Route $route_num"
route_direction=$(selectdir $route_num)
echo "> Route $route_num $route_direction"

route_stop=$(selectstop $route_num $route_direction)

getpredictions $route_stop
render

exit 0
