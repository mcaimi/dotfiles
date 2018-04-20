#!/usr/bin/env sh
# 
# Polybar Startup Script
#

# wait a little for i3 to load completely. ymmv.
sleep 2

# load Xresources
xrdb -merge $HOME/.Xresources

# source helper functions
source $HOME/.config/i3scripts/helper.sh

# LOG file
LOGFILE="/tmp/polybar-startup.log"

# clean up running polybar instances
killall -q polybar
polybar_proc=$(pgrep -u $UID -x polybar)
# Terminate already running bar instances
if [ "$polybar_proc" != "" ] ; then
    for i in ${polybar_proc} ; do
        kill -9 $i
    done
fi

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
info "[$(date)]: Killed running polybars." $LOGFILE

# Launch top & bottom bar on internal display if lid is open
is_lid_closed
if [ $? -ne 0 ]; then 
  info "[$(date)]: INTERNAL DISPLAY: Loading polybars...." $LOGFILE
  polybar top &
  polybar bottom &
fi

# Launch bar top & bottom external display
is_display_connected DP2
if [ $? -eq 0 ]; then
  info "[$(date)]: EXTERNAL DISPLAY: Loading polybars...." $LOGFILE
  info "[$(date)]: EXTERNAL DISPLAY: Switched to i3blocks, look in i3 config file...." $LOGFILE
  #polybar top-ext &
  #polybar bottom-ext &
fi

info "Bars launched..." $LOGFILE
#
