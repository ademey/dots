#!/bin/bash

# Simple screen recorder for Hyprland using wf-recorder

VIDEO_DIR="$HOME/Videos/rec"
FILENAME="screen-$(date +%Y%m%d-%H%M%S).mp4"
PIDFILE="/tmp/wf-recorder.pid"

# Create video directory if it doesn't exist
mkdir -p "$VIDEO_DIR"

# Check if already recording
if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    echo "Stopping recording..."
    kill "$(cat "$PIDFILE")"
    rm -f "$PIDFILE"
    notify-send "Screen Recording" "Recording stopped and saved to $VIDEO_DIR"
    exit 0
fi

case "${1:-full}" in
    "area"|"a")
        echo "Select area to record..."
        GEOMETRY=$(slurp)
        [ -z "$GEOMETRY" ] && exit 1
        wf-recorder -g "$GEOMETRY" -f "$VIDEO_DIR/$FILENAME" &
        ;;
    "full"|"f")
        echo "Recording full screen..."
        wf-recorder -f "$VIDEO_DIR/$FILENAME" &
        ;;
    *)
        echo "Usage: $0 [full|area]"
        echo "  full (default) - Record entire screen"
        echo "  area           - Select area to record"
        exit 1
        ;;
esac

# Store PID
echo $! > "$PIDFILE"
notify-send "Screen Recording" "Recording started: $FILENAME"
echo "Recording started. Run '$0' again to stop."

# Exit immediately so terminal doesn't hang
exit 0