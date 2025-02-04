#!/bin/bash

MAKO_CONFIG_DIR="$HOME/.config/HyprV/mako/conf"
LIGHT_CONFIG="$MAKO_CONFIG_DIR/config"
DARK_CONFIG="$MAKO_CONFIG_DIR/config-dark"
MAKO_CONFIG_TARGET="$HOME/.config/mako/config"

current_icon_theme=$(xfconf-query -c xsettings -p /Net/IconThemeName)

if [[ "$current_icon_theme" == "Adwaita-dark" ]]; then
    SWITCHTO=""
    MODESTR="Light"
    CONFIG_FILE="$LIGHT_CONFIG"
    COLOR_SCHEME="prefer-light"
else
    SWITCHTO="-dark"
    MODESTR="Dark"
    CONFIG_FILE="$DARK_CONFIG"
    COLOR_SCHEME="prefer-dark"
fi

# Update Mako config
ln -sf "$CONFIG_FILE" "$MAKO_CONFIG_TARGET"

# Change theme
xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita$SWITCHTO"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita$SWITCHTO"
gsettings set org.gnome.desktop.interface color-scheme "$COLOR_SCHEME"

# Notify user
notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "Switching to $MODESTR mode"

# Wait before restarting services
sleep 1

# Restart Mako and Waybar
pkill mako && mako &
pkill waybar && waybar &
