#!/bin/bash
#
# Helper functions

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
  ISCONNECTED=$(xrandr | grep $1 | awk '/ connected/ {print $1}')
  # not connected
  [[ -z "$ISCONNECTED" ]] && return 1

  # connected
  return 0
}


