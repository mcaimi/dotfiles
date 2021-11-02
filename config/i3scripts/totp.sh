#!/bin/bash

#ROFIDIR=$HOME/.config/rofi

function _rofi {
    #rofi -location 3 -show combi -theme $ROFIDIR/totp.rasi -xoffset -2 -yoffset 30 -tokenize -no-levenshtein-search -dmenu "$@" -p "token >"
    dmenu -l 20 -p "TOTP >" -c -bw 2
}

ROFI_MENU_CONTENTS="---\n"
ROFI_MENU_CONTENTS+="TOTP Token List\n"
ROFI_MENU_CONTENTS+="---\n"

while read -r token_line
do
   ROFI_MENU_CONTENTS+="$token_line\n"
done <<< "$(/usr/bin/env python /usr/local/bin/pytoken-rofi.py)"

ROFI_MENU_CONTENTS+="---\n"
ROFI_MENU_CONTENTS+="Select an entry to copy the Token Value to clipboard\n"

TOKEN_VALUE=$(echo -e "$ROFI_MENU_CONTENTS"|_rofi)

cd ~ || return

# parse output
token=$(echo "$TOKEN_VALUE"|grep -Eo '[0-9]{4,6}')
echo "$token"|xclip -in

