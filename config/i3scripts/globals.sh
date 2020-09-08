#!/bin/bash
#
# Globals

# PATHS
STATEPATH="/tmp/statepath"
[[ ! -d $STATEPATH ]] && mkdir -p $STATEPATH
LIDSTATE="/proc/acpi/button/lid/LID/state"
I3LOG="/tmp/i3-sessionlog"
SSH_KEYPATH="$HOME/.ssh/"

# default brightness of the main display
# its value must be in the range 0 < x < 1,
# where 0 is black and 1 is 100% brightness
# in this case, default is 0.9 which is 90% brightness
DEFAULT_BACK_LIGHT_VALUE=0.9

# Misc settings
declare -A I3ENV
I3ENV=(["wallpaper"]="$HOME/.config/i3walls/wallpaper")

# displays
declare -A DISPLAYS
DISPLAYS=(["internal"]="eDP1" ["external"]="HDMI2")

# ssh keys
declare -A KEYS
KEYS=(["github"]="id_rsa_github" ["openstack"]="id_rsa_openstack" ["ansible"]="id_rsa_ansible" ["gitlab"]="id_rsa_gitlab")

# networkmanager and other applets that should appear in the systray
declare -A APPLETS
APPLETS=(["MEGASYNC"]="megasync" ["PROTONMAILBRIDGE"]="protonmail-bridge" ["NetworkManager"]="nm-applet")


