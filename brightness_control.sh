#!/bin/bash

# Brightness control using brightnessctl
# Works without root permissions

STEP=5  # Percentage step for brightness change

# Main logic
case "$1" in
    up)
        brightnessctl set +${STEP}% > /dev/null
        ;;
    down)
        brightnessctl set ${STEP}%- > /dev/null
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Get current brightness percentage
BRIGHTNESS=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')

# Show notification with progress bar
dunstify -a "Brightness Manager" -u normal -h string:x-dunst-stack-tag:brightness "Brightness: $BRIGHTNESS%" -h int:value:$BRIGHTNESS -t 2000
