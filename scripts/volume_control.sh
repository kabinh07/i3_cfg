#!/bin/bash

# Increase Volume
if [ "$1" = "up" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
fi

# Decrease Volume
if [ "$1" = "down" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ -5%
fi

# Handle mute (called after mute toggle)
if [ "$1" = "mute" ]; then
    # Just show notification, mute was already toggled
    true
fi

# Get Current Volume
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

# Limit Volume to 100%
if [ "$VOLUME" -gt 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ 100%
    VOLUME=100
fi

# Check if muted
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Show Notification with progress bar
if [ "$MUTED" = "yes" ]; then
    dunstify -a "Volume Manager" -u normal -i audio-volume-muted -h string:x-dunst-stack-tag:volume "Volume: Muted" -h int:value:0 -t 2000
else
    dunstify -a "Volume Manager" -u normal -i audio-volume-high -h string:x-dunst-stack-tag:volume "Volume: $VOLUME%" -h int:value:$VOLUME -t 2000
fi
