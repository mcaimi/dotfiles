#!/bin/bash

sleep 2

LOGFILE="/tmp/polybar-startup.log"
declare -A POLYBARS

[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

# Map polybars to displays
POLYBARS=(["eDP1"]="internal.sh" ["DP2"]="external.sh")

# act.
 echo "Starting up or reloading polybar..." >> $LOGFILE

 DSPL=`polybar -m |awk -F: '{print $1}'`
 for d in $DSPL; do
   echo "Starting/Reloading for display ${d}:${POLYBARS[$d]}..." >> $LOGFILE
   $HOME/.config/polybar/${POLYBARS[$d]}
 done


