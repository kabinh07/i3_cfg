#!/bin/bash

# Increase Volume
if [ "$1" = "up" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
fi

# Decrease Volume
if [ "$1" = "down" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ -5%
fi

# Get Current Volume
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

# Limit Volume to 100%
if [ "$VOLUME" -gt 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ 100%
    VOLUME=100
fi

# Show Notification
dunstify -r 9993 -t 10000 "  Volume Manager" "Volume: $VOLUME%" -h int:value:"$VOLUME"
