#!/bin/bash

# Set the screenshot directory
DIR="/home/kabin/Pictures/Screenshots"
mkdir -p "$DIR"

# Generate filename with timestamp
filename="$DIR/$(date +\%Y-\%m-\%d_\%H\%M\%S).png"

# Take selected screenshot and save it
maim -s "$filename" && xclip -selection clipboard -t image/png -i "$filename"
