#!/usr/bin/env bash
#
# sets the fullscreen attibute to the current window.
# this is useful for X windows that do not support proper fullscreen implementations.
# to smooth it out if polybar is visible, hide it via xdotool
#

# load helper library
source $HOME/.config/i3scripts/helper.sh

# get the current active window
ACTIVEWINDOW=$(active_window)

# POLYBAR OFFSETS
RELATIVE_OFFSET_X=0
RELATIVE_OFFSET_Y=30

# hide polybars
function flip_polybars_visibility() {
  TOPBAR="polybar-default-ext_VGA1"
  #BOTTOMBAR="polybar bottom"
  # check fs state
  FS_STATE=$(check_state fullscreen)
  if is_not_zero $FS_STATE; then
    #move_windows "${TOPBAR}" $RELATIVE_OFFSET_X $RELATIVE_OFFSET_Y 1
    #move_windows "${BOTTOMBAR}" $RELATIVE_OFFSET_X -$RELATIVE_OFFSET_Y 1
    xdo show -a $TOPBAR
    flip_state fullscreen
  else
    #move_windows "${TOPBAR}" $RELATIVE_OFFSET_X -$RELATIVE_OFFSET_Y 1
    #move_windows "${BOTTOMBAR}" $RELATIVE_OFFSET_X $RELATIVE_OFFSET_Y 1
    xdo hide -a $TOPBAR
    flip_state fullscreen
  fi
}

# fullscreen enable and hide polybar if needed
if window_is_fullscreen $ACTIVEWINDOW; then
  # disable fullscreen for current active window
  i3-msg "[id=${ACTIVEWINDOW}] fullscreen disable"
  # show polybars
  flip_polybars_visibility
else
  # enable fullscreen for current active window
  i3-msg "[id=${ACTIVEWINDOW}] fullscreen enable"
  # show polybars
  flip_polybars_visibility
fi

#
