#!/bin/bash

function _rofi {
    rofi -location 3 -show combi -xoffset -5 -yoffset 32 -lines 20 -theme $HOME/.config/rofi/totp.rasi  -tokenize -no-levenshtein-search -dmenu "$@" -p "token >"
}

ROFI_MENU_CONTENTS="---\n"
ROFI_MENU_CONTENTS+="TOTP Token List\n"
ROFI_MENU_CONTENTS+="---\n"

while read token_line
do
   ROFI_MENU_CONTENTS+="$token_line\n"
done <<< "$(/usr/bin/env python /usr/local/bin/pytoken-rofi.py)"

ROFI_MENU_CONTENTS+="---\n"
ROFI_MENU_CONTENTS+="Select an entry to copy the Token Value to clipboard\n"

TOKEN_VALUE=$(echo -e $ROFI_MENU_CONTENTS|_rofi)

cd ~

# parse output
token=$(echo $TOKEN_VALUE|grep -Eo '[0-9]{4,6}')
echo $token|xclip -in

