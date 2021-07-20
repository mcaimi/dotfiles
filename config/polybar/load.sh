#!/usr/bin/env sh
# 
# Polybar Startup Script
#

# wait a little for i3 to load completely. ymmv.
sleep 1

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

# Launch bars on internal display if lid is open
is_lid_closed
if [ $? -ne 0 ]; then 
  info "[$(date)]: INTERNAL DISPLAY: Loading polybars...." $LOGFILE
  polybar -c $HOME/.config/polybar/config.ini -q main &
fi

# Launch bar top & bottom external display
is_display_connected DisplayPort-0
if [ $? -eq 0 ]; then
  info "[$(date)]: EXTERNAL DISPLAY: Loading polybars...." $LOGFILE
  polybar -c $HOME/.config/polybar/config-ext.ini -q main-ext &
fi

info "[Polybar] Bars launched." $LOGFILE
