#!/bin/bash
#
# Initial i3 desktop manager boot script
# everything related to the initial state of the desktop 
# is set up here

# load function library
source $HOME/.config/i3scripts/helper.sh

# setup keyboard layout
info "[$(date)]: Loading keyboard layout (IT).." $I3LOG
setxkbmap -layout "it"

# load Xresources
info "[$(date)]: Loading Xresources into the XRDB.." $I3LOG
xrdb -merge $HOME/.Xresources

# startup dunst
info "[$(date)]: Starting up DUNST..." $I3LOG
dunst &

# start compton compositor
info "[$(date)]: Starting up COMPTON.." $I3LOG
compton --config $HOME/.config/compton.conf -b

# start unclutter
info "[$(date)]: Starting up XIDLEHOOK.." $I3LOG
xidlehook --time 10 --timer $HOME/.config/i3lock/i3lock.sh --notify 60 --notifier "notify-send \"XIdleHook is about to lock desktop in 60 sec..\"" --canceller "notify-send \"XIdleHook cancelled by user action.\"" --not-when-audio &

# load sRGB monitor profile
info "[$(date)]: Loading Color Profile..." $I3LOG
dispwin -d 1,1 -I /usr/share/DisplayCAL/presets/sRGB.icc

