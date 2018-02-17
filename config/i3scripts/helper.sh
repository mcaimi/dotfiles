#!/bin/bash
#
# Generic desktop library
# Helper functions
# 

# i3 session log file
I3LOG="/tmp/i3-sessionlog"
# check laptop lid status
LIDSTATE="/proc/acpi/button/lid/LID/state"
# state path
STATEPATH="/tmp/statepath"
[[ ! -d $STATEPATH ]] && mkdir -p $STATEPATH

# log helpers
function info() {
  echo "[INFO]: $1" >> $2
}
function warning() {
  echo "[WARNING]: $1" >> $2
}
function error() {
  echo "[ERROR]: $1" >> $2
}
# disable dpms
function disable_dpms() {
  xset dpms 0 0 0
}

# Call i3-lock
function i3_lock() {
  info "[$(date)]: i3-lock called explicitly by user" $I3LOG
  $HOME/.config/i3lock/i3lock.sh
}

# i3 logout hook
function i3_logout() {
  info "[$(date)]: i3-msg called explicitly by user: LOGOUT REQUESTED" $I3LOG
  i3-msg exit
}

# Linux Suspend/Hibernate hook
function i3_suspend() {
  MODE=$1
  if [[ "$1" == "suspend" ]]; then
    info "[$(date)]: SUSPEND-TO-RAM REQUESTED: initiating via systemd..." $I3LOG
    systemctl suspend
  elif [[ "$1" == "hibernate" ]]; then
    info "[$(date)]: HIBERNATE ACTION REQUESTED: initiating via systemd..." $I3LOG
    systemctl hibernate
  else
    error "[$DATE]: Unknown action requested. Execution aborted" $I3LOG
    return -1
  fi
}

# state files i/o helpers
function init_state_file() {
  STATEFILE=$1

  [[ ! -f $STATEFILE ]] && touch $STATEPATH/$STATEFILE

  # init file contents
  echo 0 > $STATEPATH/$STATEFILE

  is_zero $? && return 0
  return 1
}

# check state file
function check_state() {
  STATEFILE=$1

  read STATE < $STATEPATH/$STATEFILE

  if is_zero $STATE; then
    echo 0; return 0
  else
    echo 1; return 1
  fi
}

# flip state file
function flip_state() {
  STATEFILE=$1

  read FLIPVALUE < $STATEPATH/$STATEFILE

  if is_zero $FLIPVALUE; then
    echo 1 > $STATEPATH/$STATEFILE
  else
    echo 0 > $STATEPATH/$STATEFILE
  fi

  is_not_zero $? && return 1
  return 0
}

# displays
declare -A DISPLAYS
DISPLAYS=(["internal"]="eDP1" ["external"]="DP2")

# various test functions
function test_str_empty() {
  [[ -z "$1" ]] && return 0
}

function is_zero() {
  [[ $1 -eq 0 ]] && return 0
  return 1
}

function is_not_zero() {
  [[ $1 -ne 0 ]] && return 0
  return 1
}

# checks if laptop lid is open
function is_lid_closed() {
  ISCLOSED=$(grep "closed" $LIDSTATE)
  # lid is open
  test_str_empty $ISCLOSED && return 1

  # lid is closed
  return 0
}

# checks if a display is connected
function is_display_connected() {
  ISCONNECTED=$(xrandr | grep $1 | awk '/ connected/ {print $1}')
  # not connected
  test_str_empty $ISCONNECTED && return 1

  # connected
  return 0
}

# searches a PID by providing a named process (optionally with arguments)
function find_pid_by_string() {
  SEARCHSTRING="$1"
  MODE=${2:-0}

  if [[ $MODE -ne 0 ]]; then
    FOUNDPID=`pgrep -u $UID -fx "$SEARCHSTRING"` # EXACT MODE
  else
    FOUNDPID=`pgrep -u $UID -f "$SEARCHSTRING"` # GLOB MODE
  fi
  test_str_empty $FOUNDPID && return 1

  echo $FOUNDPID
  return 0
}

# X11 Window ID search by pid
function find_x11_window_id_by_pid() {
  WPID=$1
  #ACTIVESDESKTOP=`xdotool get_desktop`
  #WINDOWID=`xdotool search --desktop $ACTIVESDESKTOP --pid $WPID`
  WINDOWID=`xdotool search --screen 0 --pid $WPID`
  test_str_empty $WINDOWID && return 1

  # found window ID
  echo $WINDOWID
  return 0
}

# X11 Window ID search by window class
function find_x11_window_id_by_class() {
  CLASSNAME=$1
  #ACTIVEDESKTOP=`xdotool get_desktop`
  #WINDOWID=`xdotool search --desktop $ACTIVESDESKTOP --classname $CLASSNAME`
  WINDOWID=`xdotool search --screen 0 --classname $CLASSNAME`
  test_str_empty $WINDOWID && return 1

  # found window ID
  echo $WINDOWID
  return 0
}

# X11 Window ID search by window X11 WM_NAME
function find_x11_window_id_by_name() {
  WMNAME=$1
  #ACTIVEDESKTOP=`xdotool get_desktop`
  #WINDOWID=`xdotool search --desktop $ACTIVESDESKTOP --classname $CLASSNAME`
  WINDOWID=`xdotool search --screen 0 --name $WMNAME`
  test_str_empty $WINDOWID && return 1

  # found window ID
  echo $WINDOWID
  return 0
}

# given a window id, get the corresponding screen id
function map_wid_to_desktop() {
  WID=$1

  SCREENID=`xprop -id $WID | awk -F= '/_NET_WM_DESKTOP/ { print $2 }'`
  test_str_empty $SCREENID && return 1

  echo $SCREENID; return 0
}

# move a specific window by (x,y)
# if the fourth parameter is 1, then movement is relative to the current
# window position
function move_windows() {
  PATTERN="$1"
  SHIFT_X=$2
  SHIFT_Y=$3
  RELATIVE=$4

  # find pids...
  PIDS=$(find_pid_by_string "$PATTERN")

  for wid in $PIDS; do
    X11WIN=$(find_x11_window_id_by_pid $wid)
    for wid in $X11WIN; do
      if is_zero $RELATIVE; then
        xdotool windowmove $wid $SHIFT_X $SHIFT_Y
      else
        xdotool windowmove --relative $wid $SHIFT_X $SHIFT_Y
      fi
      is_not_zero $? && return 1
    done
  done

  return 0
}

# returns the current active window
function active_window() {
  ACTIVEWIN=`xdotool getactivewindow`
  is_not_zero $? && return 1

  echo $ACTIVEWIN
  return 0
}

# checks the fullscreen property bit for the specified window
function window_is_fullscreen() {
  WIN=$1

  FS_BIT=`xprop -id $WIN _NET_WM_STATE|awk '/_NET_WM_STATE_FULLSCREEN/ {print $1}'`
  test_str_empty $FS_BIT && return 1 # NOT FULLSCREEN
  return 0 # FULLSCREEN
}

