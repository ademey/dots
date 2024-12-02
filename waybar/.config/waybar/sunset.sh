#!/bin/bash

COUNT=$(pgrep 'hyprsunset')
STATUS="off" 
if [ $COUNT ]; 
    then STATUS="on";
    else STATUS="off";
fi

printf '{"text": "%s", "alt": "%s", "tooltip": "%s", "class": "%s" }\n' "$STATUS" "$STATUS" "$COUNT" "$STATUS"