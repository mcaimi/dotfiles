#!/bin/bash

# log file
XSESSION_LOG="/tmp/xsession-init.log"
info "Executing .xsession" $XSESSION_LOG

# include functions
source $HOME/.config/dk/scripts/helper.sh

# state files
declare -A STATEFILES
STATEFILES=(["fullscreen"]="fullscreen")

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
  info "Starting in office mode: External Monitor online" $XSESSION_LOG
  xrandr --output ${DISPLAYS["internal"]} --off --output ${DISPLAYS["external"]} --auto --primary
else
  info "Starting in multimonitor mode: Internal Monitor online & primary, External Monitor online left of eDP1" $XSESSION_LOG
  xrandr --output ${DISPLAYS["internal"]} --auto --output ${DISPLAYS["external"]} --auto --primary --left-of ${DISPLAYS["internal"]}
fi

# start ssh-agent
info "Starting ssh-agent" $XSESSION_LOG
eval $(ssh-agent -s)

# set initial screen back lighting level
xrandr --output ${DISPLAYS["internal"]} --brightness ${DEFAULT_BACK_LIGHT_VALUE}
