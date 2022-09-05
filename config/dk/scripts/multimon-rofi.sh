#!/bin/bash
# XRandr integration for Rofi

function _dmenu {
    dmenu -l 12 -p "MULTI MONITOR >" -bw 2
}

DMENU_MENU_CONTENTS="---\n"
DMENU_MENU_CONTENTS+="Switch XRandr Layout\n"
DMENU_MENU_CONTENTS+="---\n"
DMENU_MENU_CONTENTS+="1: Docked Mode (External ON, Internal OFF)\n"
DMENU_MENU_CONTENTS+="2: Undocked Mode (Internal ON, External OFF)\n"
DMENU_MENU_CONTENTS+="3: Xinerama, extended to the left\n"
DMENU_MENU_CONTENTS+="4: Xinerama, extended to the right\n"
DMENU_MENU_CONTENTS+="5: Mirror screens\n"
DMENU_MENU_CONTENTS+="6: Reset (Panic Mode)\n"
DMENU_MENU_CONTENTS+="---\n"
DMENU_MENU_CONTENTS+="Select an entry and press Return.\n"

COMMAND_SELECTION=$(echo -e "$DMENU_MENU_CONTENTS"|_dmenu|awk -F: '{print $1}')

# run xrandr with selected layout configuration
case $COMMAND_SELECTION in
  "1")  $HOME/.config/dk/scripts/multimon.sh "dock" && i3-msg restart
        ;;
  "2")  $HOME/.config/dk/scripts/multimon.sh "undock" && i3-msg restart
        ;;
  "3")  $HOME/.config/dk/scripts/multimon.sh "extleft" && i3-msg restart
        ;;
  "4")  $HOME/.config/dk/scripts/multimon.sh "extright" && i3-msg restart
        ;;
  "5")  $HOME/.config/dk/scripts/multimon.sh "mirror" && i3-msg restart
        ;;
  "6")  $HOME/.config/dk/scripts/multimon.sh "panic" && i3-msg restart
        ;;
esac

