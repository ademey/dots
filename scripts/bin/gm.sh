#!/usr/bin/bash
# Bash script to manage dotplan files
# Copies incomplete todos from previous days dotplan
# Summarized progress from yesterday
# Initializes a new plan for today
# 🌞🌛
# Icon reference
#      
# [x] [ ] [-]
# ✅🔄⭕➡ 🚫

# Greeter
# NOTE: Want to do this first before any processes
# Could this be more efficient
# TODO: Include image in script
# echo "$(cat ~/Notes/ascii/gm.ascii)"


# config
plan_dir=~/Notes/dotplans
link_file=~/Notes/today.md
template_file=~/Notes/dotplans/today.md.template
# https://github.com/chubin/wttr.in
# ?m0TQ (multiline view)
# ?m&format=1
wttr_url="wttr.in/Chicago?m&format=1"

#
date_today=$(date +"%Y-%m-%d")
date_yesterday=$(date +"%Y-%m-%d" --date="yesterday")
file_today=$plan_dir/$date_today.md
file_yesterday=$plan_dir/$date_yesterday.md


# [ ] open, [-] declined, [x] done
open="> No open tasks"
declined="> No declined tasks"
done="> No complete tasks"

today_info="🌞 $(date +"%H:%M")"
yesterday_info="__no plan__"

handle_yesterday() {
    if [ -f $file_yesterday ]; then
        # Get todos from yesterday.
        open=$(grep "^-\s\[\s\]" $file_yesterday)
        declined=$(grep "^-\s\[-\]" $file_yesterday)
        done=$(grep "^-\s\[x\]" $file_yesterday)

        c_open=$(wc -l <<< "$open")
        c_dec=$(wc -l <<< "$declined")
        c_done=$(wc -l <<< "$done")


        # TODO: This could be a loop of some kind
        yesterday_info="✅ $c_done  🔄 $c_open  🚫 $c_dec"
    else
        # TODO: Could make this search for the last plan
        echo "No dotplan yesterday."
    fi
}

handle_link() {
    if [ -L $link_file ]; then
        unlink $link_file
    fi
    ln -s $file_today $link_file
}

function get_weather() {
    weather=$(curl -s $wttr_url)
    echo -e $weather
}

# $1: write to file `eval_template 1`
function eval_template() {

    export H=$(date +"%A, %b %d %Y")
    export T=$today_info
    export Y=$yesterday_info
    export W=$(get_weather)
    # export W="$(curl -s $wttr_url)"
    export TASKS=$open
    if [ $1 -eq 1 ]; then
        envsubst < $template_file > $file_today
    else
        envsubst < $template_file
    fi
}

# print, quiet
# TODO: add goodnight
while getopts ':pq' opt; do
    case "$opt" in
        p)
            eval_template
            exit 0
            ;;

        q)
            echo "Shhh"
            ;;
    esac
done


if [ -f $file_today ]; then
    # TODO: Dont like this but fine for now
    echo $file_today
else
    echo "$(cat ~/Notes/ascii/gm.ascii)"

    # Get info from yesterdays dotplan
    handle_yesterday
    # Evaluate template and write
    eval_template 1
    # Setup symlink
    handle_link
fi
