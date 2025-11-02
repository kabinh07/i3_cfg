#!/bin/bash

# Modern Power Menu with styled confirmations

theme_file="/tmp/power_menu.rasi"
confirm_theme="/tmp/power_confirm.rasi"

# Main power menu theme - Dark modern design
cat > "$theme_file" << 'EOF'
* {
    bg: #1a1b26;
    bg-alt: #24283b;
    fg: #c0caf5;
    fg-alt: #565f89;
    accent: #7aa2f7;
    accent-alt: #bb9af7;
    urgent: #f7768e;
    success: #9ece6a;
    
    background-color: transparent;
    text-color: @fg;
    font: "Poppins 12";
}

window {
    width: 500px;
    background-color: @bg;
    border: 2px;
    border-color: @accent;
    border-radius: 12px;
    padding: 20px;
}

mainbox {
    background-color: transparent;
    spacing: 20px;
    children: [inputbar, listview];
}

inputbar {
    background-color: @bg-alt;
    border-radius: 8px;
    padding: 12px 16px;
    children: [prompt];
}

prompt {
    background-color: transparent;
    text-color: @accent;
    font: "Poppins Bold 13";
}

listview {
    background-color: transparent;
    columns: 1;
    lines: 5;
    spacing: 8px;
    cycle: true;
    fixed-height: true;
}

element {
    background-color: @bg-alt;
    text-color: @fg;
    border-radius: 8px;
    padding: 14px 20px;
    orientation: horizontal;
    children: [element-text];
}

element selected {
    background-color: @accent;
    text-color: @bg;
}

element-text {
    background-color: transparent;
    text-color: inherit;
    font: "Poppins Medium 12";
    vertical-align: 0.5;
}
EOF

# Confirmation dialog theme - Cleaner and more prominent
cat > "$confirm_theme" << 'EOF'
* {
    bg: #1a1b26;
    bg-alt: #24283b;
    fg: #c0caf5;
    accent: #7aa2f7;
    urgent: #f7768e;
    
    background-color: transparent;
    text-color: @fg;
    font: "Poppins 11";
}

window {
    width: 400px;
    background-color: @bg;
    border: 2px;
    border-color: @urgent;
    border-radius: 10px;
    padding: 20px;
}

mainbox {
    background-color: transparent;
    spacing: 15px;
    children: [message, listview];
}

message {
    background-color: @bg-alt;
    border-radius: 8px;
    padding: 15px;
    border: 2px;
    border-color: @urgent;
}

textbox {
    background-color: transparent;
    text-color: @fg;
    font: "Poppins Bold 12";
    vertical-align: 0.5;
    horizontal-align: 0.5;
}

listview {
    background-color: transparent;
    columns: 2;
    lines: 1;
    spacing: 10px;
    cycle: false;
}

element {
    background-color: @bg-alt;
    text-color: @fg;
    border-radius: 6px;
    padding: 12px 24px;
}

element selected.normal {
    background-color: @urgent;
    text-color: @bg;
    font: "Poppins Bold 11";
}

element-text {
    background-color: transparent;
    text-color: inherit;
    horizontal-align: 0.5;
    vertical-align: 0.5;
}
EOF

# Define menu options with better icons
declare -a options=(
    "󰍃  Logout"
    "  Reboot" 
    "  Shutdown"
    "󰤄  Suspend"
    "󰋊  Hibernate"
)

# Show main power menu
choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu \
    -i \
    -theme "$theme_file" \
    -p " Power Menu" \
    -no-custom \
    -selected-row 0)

# Function for confirmation dialog
confirm_action() {
    local message="$1"
    rofi -dmenu \
        -theme "$confirm_theme" \
        -mesg "$message" \
        -p "" \
        -no-custom \
        <<< $'  Yes\n  No'
}

# Handle user selection
case $choice in
    "󰍃  Logout")
        result=$(confirm_action "⚠ End your session and logout?")
        [[ "$result" == "  Yes" ]] && i3-msg exit
        ;;
    "  Reboot")
        result=$(confirm_action "⚠ Reboot your system now?")
        [[ "$result" == "  Yes" ]] && systemctl reboot
        ;;
    "  Shutdown")
        result=$(confirm_action "⚠ Shutdown your system now?")
        [[ "$result" == "  Yes" ]] && systemctl poweroff
        ;;
    "󰤄  Suspend")
        systemctl suspend
        ;;
    "󰋊  Hibernate")
        systemctl hibernate
        ;;
esac

# Cleanup
rm -f "$theme_file" "$confirm_theme"
