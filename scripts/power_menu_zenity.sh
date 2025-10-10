#!/bin/bash

# Power Menu using Zenity with buttons
# Simple GUI dialog approach

# Main power menu
choice=$(zenity --list \
    --radiolist \
    --title="Power Options" \
    --text="Select an action:" \
    --width=300 \
    --height=350 \
    --column="Select" \
    --column="Action" \
    --column="Description" \
    FALSE "logout" "End current session" \
    FALSE "reboot" "Restart the system" \
    FALSE "shutdown" "Power off the system" \
    FALSE "suspend" "Suspend to RAM" \
    FALSE "hibernate" "Suspend to disk" \
    2>/dev/null)

# Handle user selection
case $choice in
    "logout")
        if zenity --question --title="Confirm Logout" --text="Are you sure you want to logout?" --width=300; then
            i3-msg exit
        fi
        ;;
    "reboot")
        if zenity --question --title="Confirm Reboot" --text="Are you sure you want to reboot?" --width=300; then
            systemctl reboot
        fi
        ;;
    "shutdown")
        if zenity --question --title="Confirm Shutdown" --text="Are you sure you want to shutdown?" --width=300; then
            systemctl poweroff
        fi
        ;;
    "suspend")
        if zenity --question --title="Confirm Suspend" --text="Are you sure you want to suspend?" --width=300; then
            systemctl suspend
        fi
        ;;
    "hibernate")
        if zenity --question --title="Confirm Hibernate" --text="Are you sure you want to hibernate?" --width=300; then
            systemctl hibernate
        fi
        ;;
esac