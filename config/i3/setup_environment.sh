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
info "[$(date)]: Starting up UNCLUTTER.." $I3LOG
unclutter & 

