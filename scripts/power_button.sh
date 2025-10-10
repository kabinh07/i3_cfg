#!/bin/bash

# Floating Power Button Widget
# Creates a small floating button that can be clicked to open power menu

# Check if button is already running
if pgrep -f "power_button" > /dev/null; then
    pkill -f "power_button"
    exit 0
fi

# Create temporary CSS for the button
css_file="/tmp/power_button.css"
cat > "$css_file" << 'EOF'
window {
    background-color: rgba(30, 30, 46, 0.9);
    border-radius: 25px;
    border: 2px solid #89b4fa;
}

button {
    background-color: transparent;
    border: none;
    color: #cdd6f4;
    font-size: 20px;
    min-width: 50px;
    min-height: 50px;
    border-radius: 25px;
}

button:hover {
    background-color: rgba(137, 180, 250, 0.2);
    color: #f38ba8;
}
EOF

# Create the GTK button using yad (if available) or fallback to zenity
if command -v yad >/dev/null; then
    yad --button="⏻:0" \
        --no-buttons \
        --width=60 \
        --height=60 \
        --center \
        --on-top \
        --skip-taskbar \
        --title="Power" \
        --text="" \
        --css="$css_file" \
        --button-layout=spread &
    
    button_pid=$!
    
    # Wait for button click
    wait $button_pid
    
    # If clicked, open power menu
    if [ $? -eq 0 ]; then
        ~/.config/i3/scripts/power_menu.sh
    fi
else
    # Fallback: just open the power menu directly
    ~/.config/i3/scripts/power_menu.sh
fi

# Clean up
rm -f "$css_file"