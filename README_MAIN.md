# 🚀 Modern i3 Window Manager Configuration

A complete, production-ready i3wm setup with beautiful visual elements, productivity enhancements, and modern functionality. Perfect for developers and power users who want a minimal yet powerful desktop environment.

![i3wm Setup](https://img.shields.io/badge/i3wm-Modern_Setup-blue?style=for-the-badge&logo=i3wm)
![Ubuntu](https://img.shields.io/badge/Ubuntu-Compatible-orange?style=for-the-badge&logo=ubuntu)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## ✨ Features

### 🎨 Visual Enhancements
- **Beautiful Power Menu**: Rofi-based shutdown/restart menu with icons
- **Transparent Effects**: Picom compositor with blur and transparency
- **Custom Theme**: Dark theme with accent colors
- **Modern Fonts**: Poppins, Ionicons, and Hack Nerd Font support
- **Smart Gaps**: Intelligent window gaps that adapt to content

### 🔧 Productivity Features
- **Audio Controls**: Volume up/down/mute with visual feedback
- **Brightness Control**: Screen brightness adjustment
- **Screenshot Tool**: Quick screenshot with custom script
- **Language Switching**: Multi-language input support with ibus
- **File Manager Integration**: Quick access to file manager (Nemo)
- **Bluetooth Manager**: Easy Bluetooth device management

### 🖥️ System Integration
- **Network Manager**: WiFi and network management applet
- **System Tray**: Clean system tray with essential applets
- **Auto-lock**: Automatic screen locking with xfce4-screensaver
- **Startup Applications**: Automated application startup
- **Workspace Management**: Roman numeral workspace names (I-X)

## 📁 Directory Structure

```
~/.config/i3/
├── config                      # Main i3 configuration file
├── scripts/                    # All scripts organized here
│   ├── power_menu.sh          # Beautiful rofi power menu
│   ├── power_menu_zenity.sh   # Alternative zenity power menu
│   ├── power_button.sh        # Floating power button widget
│   ├── volume_control.sh      # Volume control with notifications
│   ├── brightness_control.sh  # Brightness control scripts
│   ├── brightness_wrapper.sh  # Brightness wrapper
│   ├── screenshot.sh          # Screenshot utility
│   ├── lang_switch.sh         # Language switching script
│   └── rand_wallpaper.sh      # Random wallpaper setter
├── configs/                   # External configurations
│   ├── picom/                 # Picom compositor config
│   └── i3blocks/              # i3blocks configuration
├── wallpapers/                # Wallpaper collection
│   └── sunset-lake-boat...jpg # Default wallpaper
├── packages.list              # Required package list
└── README_MAIN.md            # This documentation
```

## 🚀 Quick Installation

### 1. Install Required Packages

```bash
# Update package list
sudo apt update

# Install core i3 and dependencies
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
```

### 2. Clone and Install Configuration

```bash
# Backup existing configuration (if any)
mv ~/.config/i3 ~/.config/i3.backup 2>/dev/null

# Clone this repository
git clone <your-repo-url> ~/.config/i3

# Make scripts executable
chmod +x ~/.config/i3/scripts/*.sh

# Reload i3 configuration
i3-msg reload
```

### 3. Optional: Set up additional fonts

```bash
# Download and install Poppins font (if not available in repos)
# This may vary by distribution
sudo apt install fonts-poppins 2>/dev/null || echo "Poppins font not found in repos"
```

## ⌨️ Key Bindings

### Core Navigation
| Shortcut | Action |
|----------|--------|
| `Super + Return` | Open Warp Terminal |
| `Super + Shift + Return` | Open alternative terminal |
| `Super + d` | Open dmenu (application launcher) |
| `Super + e` | Open file manager (Nemo) |
| `Super + l` | Lock screen |

### Window Management
| Shortcut | Action |
|----------|--------|
| `Super + Shift + q` | Kill focused window |
| `Super + h` | Split horizontal |
| `Super + v` | Split vertical |
| `Super + f` | Toggle fullscreen |
| `Super + Shift + space` | Toggle floating |

### Power Menu
| Shortcut | Action |
|----------|--------|
| `Super + Backspace` | Open beautiful power menu |

### System Controls
| Shortcut | Action |
|----------|--------|
| `Super + Tab` | Switch language/keyboard layout |
| `Super + b` | Open Bluetooth manager |
| `Ctrl + Shift + s` | Take screenshot |
| `XF86AudioRaiseVolume` | Volume up |
| `XF86AudioLowerVolume` | Volume down |
| `XF86AudioMute` | Mute/unmute |
| `XF86MonBrightnessUp` | Brightness up |
| `XF86MonBrightnessDown` | Brightness down |

### Workspace Management
| Shortcut | Action |
|----------|--------|
| `Super + 1-0` | Switch to workspace I-X |
| `Super + Shift + 1-0` | Move window to workspace I-X |

## 🎨 Customization

### Changing Wallpaper
1. Add your wallpaper to `~/.config/i3/wallpapers/`
2. Edit the wallpaper path in `config` file:
   ```bash
   exec --no-startup-id feh --bg-scale ~/.config/i3/wallpapers/your-wallpaper.jpg
   ```

### Modifying Power Menu Theme
Edit `~/.config/i3/scripts/power_menu.sh` to change colors and styling:
- Modify the theme variables in the rofi theme section
- Change colors, fonts, or window dimensions

### Adding Custom Scripts
1. Place your script in `~/.config/i3/scripts/`
2. Make it executable: `chmod +x ~/.config/i3/scripts/your-script.sh`
3. Add keybinding in `config` file:
   ```bash
   bindsym $mod+key exec --no-startup-id ~/.config/i3/scripts/your-script.sh
   ```

## 🛠️ Troubleshooting

### Common Issues

**Power menu doesn't appear:**
- Ensure rofi is installed: `which rofi`
- Check script permissions: `ls -la ~/.config/i3/scripts/power_menu.sh`
- Test script directly: `~/.config/i3/scripts/power_menu.sh`

**Audio controls not working:**
- Install pulseaudio-utils: `sudo apt install pulseaudio-utils`
- Check if pulseaudio is running: `pulseaudio --check`

**Brightness controls not working:**
- Install brightnessctl: `sudo apt install brightnessctl`
- Check brightness devices: `brightnessctl -l`

**Transparency effects not working:**
- Ensure picom is installed and running
- Check picom config: `~/.config/i3/configs/picom/config`

### Logs and Debugging
- Check i3 logs: `journalctl --user -u i3`
- Test configurations: `i3-msg reload`
- Validate config: `i3 -C -c ~/.config/i3/config`

## 📋 Package Dependencies

See `packages.list` for a complete list of required packages.

### Essential Packages:
- `i3-wm` - Window manager core
- `rofi` - Modern application launcher
- `picom` - Compositor for effects
- `feh` - Wallpaper setter
- `brightnessctl` - Brightness control
- `pulseaudio-utils` - Audio control

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin feature-name`
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🎯 Roadmap

- [ ] Add polybar configuration option
- [ ] Create installation script
- [ ] Add more rofi themes
- [ ] Workspace-specific wallpapers
- [ ] Dynamic color scheme switching
- [ ] Integration with popular development tools

## 🙏 Acknowledgments

- [i3wm](https://i3wm.org/) - Amazing window manager
- [rofi](https://github.com/davatorium/rofi) - Beautiful application launcher
- [picom](https://github.com/yshui/picom) - Fantastic compositor

---

**Made with ❤️ for the i3wm community**

> If you find this configuration useful, please ⭐ star the repository!