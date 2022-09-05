#!/bin/bash

function _dmenu {
    dmenu -l 14 -bw 2 -p "WIRELESS NETWORKS"
}

DMENU_MENU_CONTENTS+="---\n"

# read networks from wpa_supplicant configuration
while read input_line
do
   DMENU_MENU_CONTENTS+="$input_line\n"
done <<< "$(nmcli con | awk '/wifi/ {print $1}')"

DMENU_MENU_CONTENTS+="---\n"
DMENU_MENU_CONTENTS+="Select a wireless network to connect to.\n"

WIFI_STATION="$(echo -e $DMENU_MENU_CONTENTS|_dmenu)"

NET_ID="$(echo $WIFI_STATION|awk '{print $1}')"
nmcli con up NET_ID

