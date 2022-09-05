#!/bin/bash

# log file
LOGFILE="/tmp/dk-multimon.log"
# source helper functions
source $HOME/.config/dk/scripts/helper.sh

# apply configuration
case "$1" in
  'extright')
    info "Activating Extended Mode (DP2 RIGHT)" $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --auto --right-of ${DISPLAYS["internal"]}
    ;;
  'extleft')
    info "Acivating Extended Mode (DP2 LEFT)" $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --auto --left-of ${DISPLAYS["internal"]}
    ;;
  'dock')
    info "Activating Docked Mode (DP2 Primary, eDP1 Off)" $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --off --output ${DISPLAYS["external"]} --auto --primary
    ;;
  'undock')
    info "undock" $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --off
    ;;
  'mirror')
    info "Activating Mirror Mode" $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --auto --same-as ${DISPLAYS["internal"]}
    ;;
  'panic')
    info "PANIC MODE: Resetting Xrandr Settings" $LOGFILE
    xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --off
    ;;
  *)
    info "Xrandr NO-OP." $LOGFILE
    ;;
esac

