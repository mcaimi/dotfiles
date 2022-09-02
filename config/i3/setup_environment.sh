#!/bin/bash
#
# Initial i3 desktop manager boot script
# everything related to the initial state of the desktop 
# is set up here

# load function library
source $HOME/.config/i3scripts/helper.sh

# setup keyboard layout
info "[$(date)]: Loading keyboard layout (IT).." $I3LOG
setxkbmap -layout "us"

# load Xresources
info "[$(date)]: Merging Xresources into the XRDB.." $I3LOG
xrdb -merge $HOME/.Xresources; [[ -e $HOME/.cache/wal/colors.Xresources ]] && xrdb -merge $HOME/.cache/wal/colors.Xresources; i3-msg reload

# startup dunst
info "[$(date)]: Starting up DUNST..." $I3LOG
dunst &

# start compton compositor
info "[$(date)]: Starting up COMPTON.." $I3LOG
picom --config $HOME/.config/picom.conf -b

# setup xinput properties
python $HOME/Work/dotfiles/load_xinput_settings.py

# setup ssh keyring
info "[$(date)]: Setting up SSH keyring..." $I3LOG
for keyname in ${KEYS[@]}; do
  key_load $keyname
done

