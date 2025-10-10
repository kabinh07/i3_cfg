#!/bin/bash

# Use xrandr for software brightness control
# Specify the display (laptop screen)
DISPLAY_NAME="eDP-1"

# Get current brightness
get_brightness() {
    xrandr --verbose | grep "^$DISPLAY_NAME" -A5 | grep -i brightness | cut -f2 -d' ' | head -1
}

# Set brightness
set_brightness() {
    local brightness=$1
    # Ensure brightness is within valid range (0.1 to 1.0)
    brightness=$(echo "$brightness" | bc -l)
    if (( $(echo "$brightness < 0.1" | bc -l) )); then
        brightness="0.1"
    elif (( $(echo "$brightness > 1.0" | bc -l) )); then
        brightness="1.0"
    fi
    xrandr --output "$DISPLAY_NAME" --brightness "$brightness"
    echo "$brightness"
}

# Get current brightness
CURRENT_BRIGHTNESS=$(get_brightness)

# Handle empty brightness (fallback to 1.0)
if [ -z "$CURRENT_BRIGHTNESS" ] || [ "$CURRENT_BRIGHTNESS" = "" ]; then
    CURRENT_BRIGHTNESS="1.0"
fi

# Increase Brightness
if [ "$1" = "up" ]; then
    NEW_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS + 0.1" | bc -l)
    CURRENT_BRIGHTNESS=$(set_brightness "$NEW_BRIGHTNESS")
fi

# Decrease Brightness
if [ "$1" = "down" ]; then
    NEW_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS - 0.1" | bc -l)
    CURRENT_BRIGHTNESS=$(set_brightness "$NEW_BRIGHTNESS")
fi

# Convert to percentage for display
if [ -n "$CURRENT_BRIGHTNESS" ] && [ "$CURRENT_BRIGHTNESS" != "" ]; then
    BRIGHTNESS_PERCENT=$(echo "$CURRENT_BRIGHTNESS * 100" | bc -l | cut -d. -f1)
else
    BRIGHTNESS_PERCENT=100
fi

# Ensure brightness percent is a valid number
if ! [[ "$BRIGHTNESS_PERCENT" =~ ^[0-9]+$ ]]; then
    BRIGHTNESS_PERCENT=100
fi

# Show Notification with progress bar
if [ "$BRIGHTNESS_PERCENT" -gt 50 ]; then
    ICON="display-brightness-high"
elif [ "$BRIGHTNESS_PERCENT" -gt 20 ]; then
    ICON="display-brightness-medium"
else
    ICON="display-brightness-low"
fi

# Check if dunstify is available, otherwise use notify-send
if command -v dunstify >/dev/null 2>&1; then
    dunstify -a "Brightness Manager" -u normal -i "$ICON" -h string:x-dunst-stack-tag:brightness "Brightness: $BRIGHTNESS_PERCENT%" -h int:value:$BRIGHTNESS_PERCENT -t 2000
elif command -v notify-send >/dev/null 2>&1; then
    notify-send -i "$ICON" "Brightness: $BRIGHTNESS_PERCENT%"
fi
