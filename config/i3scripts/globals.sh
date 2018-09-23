#!/bin/bash
#
# Globals

# PATHS
STATEPATH="/tmp/statepath"
[[ ! -d $STATEPATH ]] && mkdir -p $STATEPATH
LIDSTATE="/proc/acpi/button/lid/LID/state"
I3LOG="/tmp/i3-sessionlog"
SSH_KEYPATH="$HOME/.ssh/"

# displays
declare -A DISPLAYS
DISPLAYS=(["internal"]="LVDS1" ["external"]="HDMI3")

# ssh keys
declare -A KEYS
KEYS=(["github"]="id_rsa_github" ["openstack"]="id_rsa_openstack")

# networkmanager and other applets that should appear in the systray
declare -A APPLETS
APPLETS=(["COMPTRAY"]="comptray" ["NMAPPLET"]="nm-applet" ["FIREWALL"]="firewall-applet") #["MEGASYNC"]="megasync" ["KEYBASE"]="run_keybase")


