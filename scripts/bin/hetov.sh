#!/usr/bin/env bash
# export CTA_KEY=$(pass api/cta | head -n 1)
tmp_dir=$HOME/.cache/hetov
in_data=~/cta.json
key=$CTA_KEY

if [ -z "$CTA_KEY" ]; then
    echo "API key missing"
    exit 1
fi

api_url=http://lapi.transitchicago.com/api/1.0
# base_url=http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=$CTA_KEY


if [ $1 == 'arrivals' ]; then
    req="$api_url/ttarrivals.aspx?mapid=40380&max=5&outputType=JSON&key=$CTA_KEY"
    curl $req > "$tmp_dir/arrivals.json"
    jq -r '.ctatt.eta[] | { staNm, destNm, prdt }' "$tmp_dir/arrivals.json"
fi
if [ $1 == 'positions' ]; then
    req="$api_url/ttpositions.aspx?rt=blue&outputType=JSON&key=$CTA_KEY"
    curl $req > "$tmp_dir/positions.json"
    # jq -r '.ctatt' "$tmp_dir/positions.json"
fi
# data=$(cat "$tmp_dir/response.json")

# echo $data > "$tmp_dir/response.json"
#


