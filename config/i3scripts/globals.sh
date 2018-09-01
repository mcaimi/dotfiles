#!/bin/bash
#
# Global configuration data

# i3 session log file
I3LOG="/tmp/i3-sessionlog"
# check laptop lid status
LIDSTATE="/proc/acpi/button/lid/LID/state"
# state path
STATEPATH="/tmp/statepath"
[[ ! -d $STATEPATH ]] && mkdir -p $STATEPATH
SSH_KEYPATH="$HOME/.ssh/"

# Displays
declare -A DISPLAYS
DISPLAYS=(["internal"]="eDP1" ["external"]="DP2")

# ssh keys
declare -A KEYS
KEYS=(["github"]="id_rsa_github" ["openstack"]="id_rsa_openstack" ["ansible"]="id_rsa_ansible")

# networkmanager and other applets that should appear in the systray
declare -A APPLETS
APPLETS=(["COMPTRAY"]="comptray" ["MEGASYNC"]="megasync")
