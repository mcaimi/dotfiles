#!/bin/bash

# log file
LOGFILE="/tmp/multimon.log"
# source helper functions
source $HOME/.config/i3scripts/helper.sh

# apply configuration
case "$1" in
  'extright')
    echo "Activating Extended Mode (DP2 RIGHT)" >> $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --auto --right-of ${DISPLAYS["internal"]}
    ;;
  'extleft')
    echo "Acivating Extended Mode (DP2 LEFT)" >> $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --auto --left-of ${DISPLAYS["internal"]}
    ;;
  'dock')
    echo "Activating Docked Mode (DP2 Primary, eDP1 Off)" >> $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --off --output ${DISPLAYS["external"]} --auto --primary
    ;;
  'undock')
    echo "undock"
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --off
    ;;
  'mirror')
    echo "Activating Mirror Mode" >> $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --auto --same-as ${DISPLAYS["internal"]}
    ;;
  'panic')
    echo "PANIC MODE: Resetting Xrandr Settings" >> $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --off
    ;;
  *)
    echo "default"
    ;;
esac

