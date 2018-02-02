#!/bin/bash
#
# let the local user connect to the local X11 server via unix socket. Docker containers use this
xhost si:localuser:marco

# log file
XSESSION_LOG="/tmp/xsession-init.log"
info "Executing .xsession" $XSESSION_LOG

# include functions
source $HOME/.config/i3scripts/helper.sh

# state files
declare -A STATEFILES
STATEFILES=(["fullscreen"]="fullscreen")

# init state files
for initfile in ${fullscreen[@]}; do
  info "Initializing state file $initfile..." $XSESSION_LOG
  init_state_file $initfile
done

# do we need to disable the internal display?
is_lid_closed

# DEFAULT BEHAVIOUR:
# if lid is closed, external monitor is the primary monitor
if [ $? -eq 0 ]; then
  info "Starting in office mode: DP2 online" $XSESSION_LOG
  xrandr --output ${DISPLAYS["internal"]} --off --output ${DISPLAYS["external"]} --auto --primary
else # office mode: eDP1 is primary display, DP2 is secondary display left of eDP1
  info "Starting in multimonitor mode: eDP1 online & primary, DP2 online left of eDP1" $XSESSION_LOG
  xrandr --output ${DISPLAYS["internal"]} --auto --primary --output ${DISPLAYS["external"]} --auto --left-of ${DISPLAYS["internal"]}
fi

# start ssh-agent
info "Starting ssh-agent" $XSESSION_LOG
eval $(ssh-agent -s)