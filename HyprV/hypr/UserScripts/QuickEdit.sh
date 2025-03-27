#!/bin/bash
# /* ---- 💫 https://github.com/oniichanx 💫 ---- */  ##
# Rofi menu for Quick Edit/View of Settings (SUPER E)

# Define preferred text editor and terminal
edit=${EDITOR:-nano}
tty=kitty

# Paths to configuration directories
configs="$HOME/.config/hypr/configs"
UserConfigs="$HOME/.config/hypr/UserConfigs"
UserSettings="$HOME/.config/hypr/"

# Function to display the menu options
menu() {
    cat <<EOF
1. View / Edit  Default-Settings
2. View / Edit  User-Settings
3. View / Edit  Default-Keybinds
4. View / Edit  Decorations & Animations
5. View / Edit  Workspace-Rules
6. View / Edit  Workspace-Rules-new

EOF
}

# Main function to handle menu selection
main() {
    choice=$(menu | rofi -i -dmenu -config ~/.config/rofi/config-compact.rasi | cut -d. -f1)
    
    # Map choices to corresponding files
    case $choice in
        1) file="$UserConfigs/Settings.conf" ;;
        2) file="$UserSettings/hyprland.conf" ;;
        3) file="$UserConfigs/KeyBinds.conf" ;;
        4) file="$UserConfigs/UserDecorAnimations.conf" ;;
        5) file="$UserConfigs/WindowRules.conf" ;;
        6) file="$UserConfigs/WindowRules-new.conf" ;;
        *) return ;;  # Do nothing for invalid choices
    esac

    # Open the selected file in the terminal with the text editor
    $tty -e $edit "$file"
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

main
