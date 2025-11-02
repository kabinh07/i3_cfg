#!/bin/bash

# Brightness notification with rofi matching power menu theme

BRIGHTNESS="$1"

theme_file="/tmp/brightness_notify.rasi"

# Create rofi theme matching power menu
cat > "$theme_file" << 'EOF'
* {
    bg: #1a1b26;
    bg-alt: #24283b;
    fg: #c0caf5;
    accent: #e0af68;
    
    background-color: transparent;
    text-color: @fg;
    font: "Poppins 12";
}

window {
    width: 350px;
    background-color: @bg;
    border: 2px;
    border-color: @accent;
    border-radius: 12px;
    padding: 20px;
    location: north east;
    x-offset: -20;
    y-offset: 50;
}

mainbox {
    background-color: transparent;
    spacing: 15px;
    children: [message];
}

message {
    background-color: transparent;
}

textbox {
    background-color: transparent;
    text-color: @fg;
    font: "Poppins Medium 11";
}
EOF

# Build progress bar
bar_length=20
filled=$(( BRIGHTNESS * bar_length / 100 ))
empty=$(( bar_length - filled ))

bar=""
for ((i=0; i<filled; i++)); do bar+="━"; done
for ((i=0; i<empty; i++)); do bar+="─"; done

# Show notification
echo -e "☀  Brightness: $BRIGHTNESS%\n$bar" | rofi -dmenu -markup \
    -theme "$theme_file" \
    -p "" \
    -no-custom \
    -no-fixed-num-lines &

# Get rofi PID and kill after timeout
ROFI_PID=$!
sleep 1.5
kill $ROFI_PID 2>/dev/null

# Cleanup
rm -f "$theme_file"
