#!/bin/bash

MAKO_CONFIG_DIR="$HOME/.config/HyprV/mako/conf"
LIGHT_CONFIG="$MAKO_CONFIG_DIR/config"
DARK_CONFIG="$MAKO_CONFIG_DIR/config-dark"

MAKO_CONFIG_TARGET="$HOME/.config/mako/config"

current_icon_theme=$(xfconf-query -c xsettings -p /Net/IconThemeName)
#current_theme=$(gsettings get org.gnome.desktop.interface icon-theme)

if [[ "$current_icon_theme" == "Adwaita-dark" ]]; then
    SWITCHTO=""
    MODESTR="Light"
    CONFIG_FILE="$LIGHT_CONFIG"
else
    SWITCHTO="-dark"
    MODESTR="Dark"
    CONFIG_FILE="$DARK_CONFIG"
fi

ln -sf "$CONFIG_FILE" "$MAKO_CONFIG_TARGET"

xfconf-query -c xsettings -p /Net/IconThemeName -s "Adwaita$SWITCHTO"

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita$SWITCHTO"

notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "Switching to $MODESTR mode"

sleep 1
pkill mako
mako &

pkill waybar
waybar &

#echo "Switched to $MODESTR mode"