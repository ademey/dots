
#!/usr/bin/env bash

function relative() {
    # local last_unix=$(date --date="$1" +%s)    # convert date to unix timestamp
    # local now_unix=$(date --date="$2" +%s)

    local delta=$(( $2 - $1 ))
    echo "$delta"
}


function refresh() {
    count=$(($count + 1))
    last_render=$(date +%s)
    echo $count
}

function render() {
    clear
    local since_update=$(relative $last_render $(date +%s))
    local data=$(refresh)
    echo "$data -> $since_update $(($refresh_interval - $since_update))"
}

count=0
loop=1
interval=1
refresh_interval=10
max_run=300
loop_start=$(date +%s)
last_render=$(date +%s)

if [ $loop -eq 0 ]; then
    render
    exit 0
else
    while true; do
        render
        sleep $interval
    done
fi
