#!/bin/bash
#
# Initial qtile desktop manager boot script
# everything related to the initial state of the desktop is set up here

# load function library
source $HOME/.config/qtile/scripts/helper.sh

# setup keyboard layout
info "[$(date)]: Loading keyboard layout (IT).." $QTILELOG
setxkbmap -layout "us"

# load Xresources
info "[$(date)]: Merging Xresources into the XRDB.." $QTILELOG
xrdb -merge $HOME/.Xresources; [[ -e $HOME/.cache/wal/colors.Xresources ]] && xrdb -merge $HOME/.cache/wal/colors.Xresources

# startup dunst
info "[$(date)]: Starting up DUNST..." $QTILELOG
dunst &

# start compton compositor
info "[$(date)]: Starting up COMPTON.." $QTILELOG
picom --config $HOME/.config/qtile/picom.conf -b

# setup ssh keyring
info "[$(date)]: Setting up SSH keyring..." $QTILELOG
for keyname in ${KEYS[@]}; do
  key_load $keyname
done

