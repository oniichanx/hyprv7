#!/bin/bash
# /* ---- 💫 https://github.com/oniichanx 💫 ---- */  ##
# For applying Animations from different users

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

# Variables
iDIR="$HOME/.config/HyprV/mako/icons"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
animations_dir="$HOME/.config/hypr/animations"
UserConfigs="$HOME/.config/hypr/"

# list of animation files
animations_list=$(find "$animations_dir" -maxdepth 1 -type f | sed 's/.*\///' | sed 's/\.conf$//')

# Rofi Menu
chosen_file=$(echo "$animations_list" | rofi -i -dmenu -config ~/.config/rofi/config-Animations.rasi)

# Check if a file was selected
if [[ -n "$chosen_file" ]]; then
    # Find the full path of the chosen file
    full_path="$animations_dir/$chosen_file.conf"
    
    cp "$full_path" "$UserConfigs/UserAnimations.conf"
    
    notify-send -u low -i "$iDIR/bell.png" "$chosen_file" "Hyprland Animation Loaded"
else
    notify-send -u low -i "$iDIR/bell.png" "You chose to NOT" "to apply other Hyprland animations"
fi

sleep 1
"$SCRIPTSDIR/RefreshNoWaybar.sh"