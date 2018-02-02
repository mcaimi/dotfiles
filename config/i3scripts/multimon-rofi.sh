#!/bin/bash
# XRandr integration for Rofi

function _rofi {
    rofi -lines 12 -tokenize -no-levenshtein-search -dmenu "$@" -p "XRandr >"
}

ROFI_MENU_CONTENTS="---\n"
ROFI_MENU_CONTENTS+="Switch XRandr Layout\n"
ROFI_MENU_CONTENTS+="---\n"
ROFI_MENU_CONTENTS+="1: Docked Mode (External ON, Internal OFF)\n"
ROFI_MENU_CONTENTS+="2: Undocked Mode (Internal ON, External OFF)\n"
ROFI_MENU_CONTENTS+="3: Xinerama, extended to the left\n"
ROFI_MENU_CONTENTS+="4: Xinerama, extended to the right\n"
ROFI_MENU_CONTENTS+="5: Mirror screens\n"
ROFI_MENU_CONTENTS+="6: Reset (Panic Mode)\n"
ROFI_MENU_CONTENTS+="---\n"
ROFI_MENU_CONTENTS+="Select an entry and press Return.\n"

COMMAND_SELECTION=$(echo -e $ROFI_MENU_CONTENTS|_rofi|awk -F: '{print $1}')

# run xrandr with selected layout configuration
case $COMMAND_SELECTION in
  "1")  $HOME/.config/i3scripts/multimon.sh "dock" && i3-msg restart
        ;;
  "2")  $HOME/.config/i3scripts/multimon.sh "undock" && i3-msg restart
        ;;
  "3")  $HOME/.config/i3scripts/multimon.sh "extleft" && i3-msg restart
        ;;
  "4")  $HOME/.config/i3scripts/multimon.sh "extright" && i3-msg restart
        ;;
  "5")  $HOME/.config/i3scripts/multimon.sh "mirror" && i3-msg restart
        ;;
  "6")  $HOME/.config/i3scripts/multimon.sh "panic" && i3-msg restart
        ;;
esac

