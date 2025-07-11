#!/bin/bash

# Specify the backlight device
DEVICE="intel_backlight"

# Increase Brightness
if [ "$1" = "up" ]; then
    brightnessctl -d "$DEVICE" set +10%
fi

# Decrease Brightness
if [ "$1" = "down" ]; then
    brightnessctl -d "$DEVICE" set 10%-
fi

# Get Current Brightness
BRIGHTNESS=$(brightnessctl -d "$DEVICE" get)
MAX_BRIGHTNESS=$(brightnessctl -d "$DEVICE" max)
BRIGHTNESS_PERCENT=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

# Show Notification with progress bar
if [ "$BRIGHTNESS_PERCENT" -gt 50 ]; then
    ICON="display-brightness-high"
elif [ "$BRIGHTNESS_PERCENT" -gt 20 ]; then
    ICON="display-brightness-medium"
else
    ICON="display-brightness-low"
fi

dunstify -a "Brightness Manager" -u normal -i "$ICON" -h string:x-dunst-stack-tag:brightness "Brightness: $BRIGHTNESS_PERCENT%" -h int:value:$BRIGHTNESS_PERCENT -t 2000
