#!/usr/bin/env sh

# ymmv
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
echo "Killed running polybars." >> $LOGFILE

# Launch top & bottom bar on internal display if lid is open
is_lid_closed
if [ $? -ne 0 ]; then 
  echo "INTERNAL DISPLAY: Loading polybars...." >> $LOGFILE
  polybar top &
  polybar bottom &
fi

# Launch bar top & bottom external display
is_display_connected DP2
if [ $? -eq 0 ]; then
  echo "EXTERNAL DISPLAY: Loading polybars...." >> $LOGFILE
  polybar top-ext &
  polybar bottom-ext &
fi

echo "Bars launched..."
