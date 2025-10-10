#!/bin/bash

# Power Menu using rofi with icons
# Icons and colors configuration

theme_file="/tmp/power_menu.rasi"

# Create temporary rofi theme with custom styling
cat > "$theme_file" << 'EOF'
* {
    bg-col: #1e1e2e;
    bg-col-light: #313244;
    border-col: #89b4fa;
    selected-col: #313244;
    blue: #89b4fa;
    fg-col: #cdd6f4;
    fg-col2: #f38ba8;
    grey: #6c7086;
    
    width: 400px;
    font: "Poppins Bold 14";
}

element-text, element-icon, mode-switcher {
    background-color: inherit;
    text-color: inherit;
}

window {
    height: 300px;
    border: 3px;
    border-color: @border-col;
    border-radius: 8px;
    background-color: @bg-col;
}

mainbox {
    background-color: @bg-col;
}

inputbar {
    children: [prompt];
    background-color: @bg-col-light;
    border-radius: 5px;
    padding: 2px;
}

prompt {
    background-color: @blue;
    padding: 6px;
    text-color: @bg-col;
    border-radius: 3px;
    margin: 20px 0px 0px 20px;
}

listview {
    border: 0px 0px 0px;
    padding: 6px 0px 0px;
    margin: 10px 0px 0px 20px;
    columns: 1;
    lines: 5;
    background-color: @bg-col;
}

element {
    padding: 8px;
    background-color: @bg-col;
    text-color: @fg-col;
    margin: 0px 5px 0px 0px;
    border-radius: 5px;
}

element-icon {
    size: 32px;
}

element selected {
    background-color: @selected-col;
    text-color: @fg-col2;
}
EOF

# Define menu options
declare -a options=(
    "󰍃 Logout"
    "󰜉 Reboot" 
    "󰐥 Shutdown"
    "󰒲 Suspend"
    "󰒳 Hibernate"
)

# Show rofi menu and capture selection
choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu \
    -i \
    -theme "$theme_file" \
    -p "Power Options" \
    -selected-row 0)

# Remove temporary theme file
rm -f "$theme_file"

# Handle user selection
case $choice in
    "󰍃 Logout")
        i3-msg exit
        ;;
    "󰜉 Reboot")
        # Show confirmation
        confirm=$(echo -e "Yes\nNo" | rofi -dmenu -p "Reboot now?" -theme-str "window {width: 200px;}")
        [[ "$confirm" == "Yes" ]] && systemctl reboot
        ;;
    "󰐥 Shutdown")
        # Show confirmation  
        confirm=$(echo -e "Yes\nNo" | rofi -dmenu -p "Shutdown now?" -theme-str "window {width: 200px;}")
        [[ "$confirm" == "Yes" ]] && systemctl poweroff
        ;;
    "󰒲 Suspend")
        systemctl suspend
        ;;
    "󰒳 Hibernate")
        systemctl hibernate
        ;;
esac