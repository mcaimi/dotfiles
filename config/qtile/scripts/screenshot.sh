#!/bin/bash

function _dmenu {
    dmenu -l 15 -p "SCREENSHOT >" -bw 2
}

MAIM_DIR="${HOME}/Pictures/Maim"

if [ ! -d "${MAIM_DIR}" ]; then
  mkdir -p "${MAIM_DIR}"
fi

DMENU_MENU_CONTENTS+="1: Take screenshot of the whole desktop\n"
DMENU_MENU_CONTENTS+="2: Take screenshot of a specific window.\n"
DMENU_MENU_CONTENTS+="3: Take screenshot of a custom screen area.\n"
DMENU_MENU_CONTENTS+="4: Take screenshot of the currently active window.\n"
DMENU_MENU_CONTENTS+="5: Grab a screen selection and copy it to clipboard.\n"
DMENU_MENU_CONTENTS+="\n"
DMENU_MENU_CONTENTS+="Select an entry, screen will be saved in ${MAIM_DIR}\n"

COMMAND_SELECTION=$(echo -e "$DMENU_MENU_CONTENTS"|_dmenu|awk -F: '{print $1}')

# call maim and friends
case $COMMAND_SELECTION in
  "1")  maim ${MAIM_DIR}/$(date +%s).png
        ;;
  "2")  maim -i$(xdotool selectwindow) ${MAIM_DIR}/$(date +%s).png
        ;;
  "3")  maim -s ${MAIM_DIR}/$(date +%s).png
        ;;
  "4")  maim -i$(xdotool getactivewindow) ${MAIM_DIR}/$(date +%s).png
        ;;
  "5")  maim -s |xclip -selection clipboard -t image/png
        ;;
esac

