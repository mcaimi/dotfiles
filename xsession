#!/bin/bash
#
# let the local user connect to the local X11 server via unix socket. Docker containers use this
xhost si:localuser:marco

# include functions
source $HOME/.config/i3scripts/helper.sh

# do we need to disable the internal display?
is_lid_closed

# DEFAULT BEHAVIOUR:
# if lid is closed, external monitor is the primary monitor
if [ $? -eq 0 ]; then
  xrandr --output ${DISPLAYS["internal"]} --off --output ${DISPLAYS["external"]} --auto --primary
else # office mode: eDP1 is primary display, DP2 is secondary display left of eDP1
  xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --auto --left-of ${DISPLAYS["internal"]}
fi

# start ssh-agent
eval $(ssh-agent -s)
