#!/usr/bin/env bash

echo "Normal..."
notify-send "Message Type" "This is the message body" -t 5000

echo "Plain..."
sleep 1 && notify-send "Low" "This is the message body" -u low 
sleep 1 && notify-send "Normal" "This is the message body" -u normal
sleep 1 && notify-send "Critical" "This is the message body" -u critical

