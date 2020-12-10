#!/bin/bash
#
# Globals

# PATHS
STATEPATH="/tmp/statepath"
[[ ! -d $STATEPATH ]] && mkdir -p $STATEPATH
LIDSTATE="/proc/acpi/button/lid/LID/state"
I3LOG="/tmp/i3-sessionlog"
SSH_KEYPATH="$HOME/.ssh/"

# Misc settings
declare -A I3ENV
I3ENV=(["wallpaper"]="$HOME/.config/i3walls/wallpaper")

# displays
declare -A DISPLAYS
DISPLAYS=(["internal"]="DisplayPort-0" ["external"]="HDMI-A-0")

# ssh keys
declare -A KEYS
KEYS=(["github"]="id_rsa_github" ["openstack"]="id_rsa_openstack" ["ansible"]="id_rsa_ansible" ["gitlab"]="id_rsa_gitlab")

# networkmanager and other applets that should appear in the systray
declare -A APPLETS
#APPLETS=(["COMPTRAY"]="comptray" ["PROTONMAILBRIDGE"]="protonmail-bridge" ["MEGASYNC"]="megasync" ["OBINSKIT"]="/usr/bin/obinskit")
APPLETS=(["COMPTRAY"]="comptray" ["PROTONMAILBRIDGE"]="protonmail-bridge" ["OBINSKIT"]="/usr/bin/obinskit" ["NMAPPLET"]="nm-applet")

