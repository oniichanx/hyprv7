#!/bin/bash

# Load configuration from hyprv.conf
. ~/.config/HyprV/hyprv.conf

switch_keyboard() {
    hyprctl switchxkblayout $SET_KB next
}

restart_waybar() {
    # Restart waybar
    pkill waybar
    waybar &
}

# Main script

if [[ "$1" == "swkb" ]]; then
    switch_keyboard
fi
