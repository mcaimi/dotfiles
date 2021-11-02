#!/bin/bash

ROFICONFIG="$HOME/.config/rofi"

function _rofi {
    #rofi -location 3 -show combi -theme $ROFICONFIG/wifi.rasi -xoffset -2 -yoffset 30 -tokenize -no-levenshtein-search -dmenu "$@" -p "wireless >"
    dmenu -l 14
}

OFI_MENU_CONTENTS+="---\n"

# read networks from wpa_supplicant configuration
while read input_line
do
   ROFI_MENU_CONTENTS+="$input_line\n"
done <<< "$(nmcli con | awk '/wifi/ {print $1}')"

ROFI_MENU_CONTENTS+="---\n"
ROFI_MENU_CONTENTS+="Select a wireless network to connect to.\n"

WIFI_STATION="$(echo -e $ROFI_MENU_CONTENTS|_rofi)"

NET_ID="$(echo $WIFI_STATION|awk '{print $1}')"
nmcli con up NET_ID

