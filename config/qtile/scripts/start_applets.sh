#!/bin/bash
#
# Applets startup script.
# These applets will appear in the traybox in polybar.

source $HOME/.config/qtile/scripts/helper.sh

for applet in ${APPLETS[@]};
do
  #cleanup if necessary...
  pkill -u $UID $applet
  info "[$(date)]: Starting up Applet: $applet..." $DKLOG
  $applet &
  is_not_zero && error "[$(date)]: Startup of applet $applet failed!" $DKLOG
done
