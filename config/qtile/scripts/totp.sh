#!/bin/bash

function _dmenu {
    dmenu -l 20 -p "TOTP >" -bw 2
}

DMENU_MENU_CONTENTS="---\n"
DMENU_MENU_CONTENTS+="TOTP Token List\n"
DMENU_MENU_CONTENTS+="---\n"

while read -r token_line
do
   DMENU_MENU_CONTENTS+="$token_line\n"
done <<< "$(/usr/bin/env python /usr/local/bin/pytoken-cli.py)"

DMENU_MENU_CONTENTS+="---\n"
DMENU_MENU_CONTENTS+="Select an entry to copy the Token Value to clipboard\n"

TOKEN_VALUE=$(echo -e "$DMENU_MENU_CONTENTS"|_dmenu)

cd ~ || return

# parse output
token=$(echo "$TOKEN_VALUE"|grep -Eo '[0-9]{4,6}')
echo "$token"|xclip -in

