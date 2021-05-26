#!/bin/bash
# MAIM integration for Rofi

RASIDIR="$HOME/.config/rofi"

function _rofi {
    rofi -location 0 -show combi -theme $RASIDIR/screenshot.rasi -lines 22 -width 45 -tokenize -no-levenshtein-search -dmenu "$@" -p "screenshot >"
}

MAIM_DIR="${HOME}/Pictures/Maim"

if [ ! -d ${MAIM_DIR} ]; then
  mkdir -p ${MAIM_DIR}
fi

ROFI_MENU_CONTENTS+="1: Take screenshot of the whole desktop\n"
ROFI_MENU_CONTENTS+="2: Take screenshot of a specific window.\n"
ROFI_MENU_CONTENTS+="3: Take screenshot of a custom screen area.\n"
ROFI_MENU_CONTENTS+="4: Take screenshot of the currently active window.\n"
ROFI_MENU_CONTENTS+="5: Grab a screen selection and copy it to clipboard.\n"
ROFI_MENU_CONTENTS+="\n"
ROFI_MENU_CONTENTS+="Select an entry, screen will be saved in ${MAIM_DIR}\n"

COMMAND_SELECTION=$(echo -e $ROFI_MENU_CONTENTS|_rofi|awk -F: '{print $1}')

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

