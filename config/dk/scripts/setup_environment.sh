#!/bin/bash
#
# Initial DK desktop manager boot script
# everything related to the initial state of the desktop is set up here

# load function library
source $HOME/.config/dk/scripts/helper.sh

# setup keyboard layout
info "[$(date)]: Loading keyboard layout (IT).." $DKLOG
setxkbmap -layout "us"

# load Xresources
info "[$(date)]: Merging Xresources into the XRDB.." $DKLOG
xrdb -merge $HOME/.Xresources; [[ -e $HOME/.cache/wal/colors.Xresources ]] && xrdb -merge $HOME/.cache/wal/colors.Xresources

# startup dunst
info "[$(date)]: Starting up DUNST..." $DKLOG
dunst &

# start compton compositor
info "[$(date)]: Starting up COMPTON.." $DKLOG
picom --config $HOME/.config/dk/picom.conf -b

# setup xinput properties
python $HOME/.config/dk/scripts/load_xinput_settings.py

# setup ssh keyring
info "[$(date)]: Setting up SSH keyring..." $DKLOG
for keyname in ${KEYS[@]}; do
  key_load $keyname
done

