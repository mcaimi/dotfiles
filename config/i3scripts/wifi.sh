#!/bin/bash

function _rofi {
    rofi -location 3 -show combi -padding 2 -xoffset -5 -yoffset 30 -bw 0 -lines 25 -width 35 -font "iosevka term medium 11" -tokenize -no-levenshtein-search -dmenu "$@" -p "wireless >"
}

OFI_MENU_CONTENTS+="---\n"

# read networks from wpa_supplicant configuration
while read input_line
do
   ROFI_MENU_CONTENTS+="$input_line\n"
done <<< "$(wpa_cli list_networks)"

ROFI_MENU_CONTENTS+="---\n"
ROFI_MENU_CONTENTS+="Select a wireless network to connect to.\n"

WIFI_STATION="$(echo -e $ROFI_MENU_CONTENTS|_rofi)"

NET_ID="$(echo $WIFI_STATION|awk '{print $1}')"
wpa_cli select_network $NET_ID

