#!/bin/bash
# 
# Applets startup script.
# These applets will appear in the traybox in polybar.
#

source $HOME/.config/i3scripts/helper.sh

# let i3 load polybar completely...
sleep 2

for applet in ${APPLETS[@]};
do
  #cleanup if necessary...
  pkill -u $UID $applet
  info "[$(date)]: Starting up Applet: $applet..." $I3LOG
  $applet &
  is_not_zero && error "[$(date)]: Startup of applet $applet failed!" $I3LOG
done
