#!/bin/bash

# i3 Window Manager Setup Installation Script
# ===========================================

set -e  # Exit on any error

echo "🚀 i3 Window Manager Modern Setup Installer"
echo "==========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

# Check if running on supported distribution
if ! command -v apt &> /dev/null; then
    log_error "This script is designed for Debian/Ubuntu systems with apt package manager"
    exit 1
fi

log_info "Starting i3wm setup installation..."

# Update package list
log_info "Updating package list..."
sudo apt update

# Install core packages
log_info "Installing required packages..."
sudo apt install -y \
    i3-wm i3status i3lock dmenu \
    xorg xserver-xorg-core xinit \
    feh picom rofi \
    pulseaudio pulseaudio-utils alsa-utils \
    systemd acpi brightnessctl scrot zenity \
    notification-daemon libnotify-bin \
    xinput ibus \
    xss-lock xautolock xfce4-screensaver \
    network-manager nm-applet \
    bluez blueman \
    nemo \
    fonts-font-awesome fonts-hack fonts-ionicons \
    dex git

log_success "Packages installed successfully!"

# Make scripts executable
log_info "Making scripts executable..."
chmod +x ~/.config/i3/scripts/*.sh

log_success "Scripts made executable!"

# Test i3 configuration
log_info "Validating i3 configuration..."
if i3 -C -c ~/.config/i3/config; then
    log_success "i3 configuration is valid!"
else
    log_error "i3 configuration validation failed!"
    exit 1
fi

# Reload i3 if currently running
if pgrep i3 > /dev/null; then
    log_info "Reloading i3 configuration..."
    i3-msg reload
    log_success "i3 configuration reloaded!"
fi

# Final message
echo
echo "🎉 Installation completed successfully!"
echo
echo "📋 Next steps:"
echo "1. Log out and log back in (or restart X session)"
echo "2. Select i3 as your window manager in login screen"
echo "3. Press Super+Backspace to test the new power menu"
echo
echo "⌨️  Key bindings:"
echo "   Super+Return          - Open terminal"
echo "   Super+d               - Application launcher"
echo "   Super+Backspace       - Power menu"
echo "   Super+e               - File manager"
echo "   Super+l               - Lock screen"
echo
echo "📖 For full documentation, see README_MAIN.md"
echo
log_success "Enjoy your new i3wm setup! 🚀"