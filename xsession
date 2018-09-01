#!/bin/bash
#
# let the local user connect to the local X11 server via unix socket. Docker containers use this
xhost si:localuser:marco

# log file
XSESSION_LOG="/tmp/xsession-init.log"
info "Executing .xsession" $XSESSION_LOG

# include functions
source $HOME/.config/i3scripts/helper.sh

# init state files
for initfile in ${STATEFILES[@]}; do
  info "Initializing state file $initfile..." $XSESSION_LOG
  init_state_file $initfile
done

# do we need to disable the internal display?
is_lid_closed

# DEFAULT BEHAVIOUR:
# if lid is closed, external monitor is the primary monitor
if [ $? -eq 0 ]; then
  info "Starting in office mode: External Display online" $XSESSION_LOG
  xrandr --output ${DISPLAYS["internal"]} --off --output ${DISPLAYS["external"]} --auto --primary
else
  info "Starting in laptop mode: Internal Display online & primary" $XSESSION_LOG
  xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --off
fi

# start ssh-agent
info "Starting ssh-agent" $XSESSION_LOG
eval $(ssh-agent -s)

