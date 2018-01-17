#!/bin/bash
#
# let the local user connect to the local X11 server via unix socket. Docker containers use this
xhost si:localuser:marco

# check laptop lid status
LIDSTATE="/proc/acpi/button/lid/LID/state"

# displays
declare -A DISPLAYS
DISPLAYS=(["internal"]="eDP1" ["external"]="DP2")

function is_lid_closed() {
  ISCLOSED=$(grep "closed" $LIDSTATE)
  # lid is open
  [[ -z "$ISCLOSED" ]] && return 1
  # lid is closed
  return 0
}

function is_display_connected() {
  DISPLAY=${1}
  ISCONNECTED=$(xrandr | awk '/connected/ {print $1}')
}

# do we need to disable the internal display?
is_lid_closed
# if lid is closed, external monitor is the primary monitor
[[ $? -eq 0 ]] && xrandr --output ${DISPLAYS["internal"]} --off --output ${DISPLAYS["external"]} --auto --primary

# start ssh-agent
eval $(ssh-agent -s)
