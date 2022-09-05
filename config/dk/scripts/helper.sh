#!/bin/bash
#
# DK desktop library
# Helper functions
#

# load monitor information
source $HOME/.config/dk/scripts/globals.sh

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
  xset s noblank
  xset dpms s off
}

# lookup key in the keyring.
function lookup_key() {
  ssh-add -l | grep $1
  is_zero $? && return 0
  return 1
}

# use ssh-add to load key into keyring
function key_load() {
 if [[ -e $SSH_KEYPATH/$1 ]]; then
  if lookup_key $1; then
    info "[$(date)]: Key $1 already registered in the keyring" $DKLOG
    return 0
  else
    ssh-add $SSH_KEYPATH/$1
    info "[$(date)]: Added $1 to the ssh keyring" $DKLOG
    return 0
  fi
 else
   info "[$(date)]: Key $1 not found." $DKLOG
   return 1
 fi
}

# Call dk-lock
function dk_lock() {
  info "[$(date)]: dm-tool called explicitly by user" $DKLOG
  dm-tool lock
}

# i3 logout hook
function dk_logout() {
  info "[$(date)]: dkcmd called explicitly by user: LOGOUT REQUESTED" $DKLOG
  dkcmd exit
}

# Linux Suspend/Hibernate hook
function suspend() {
  MODE=$1
  if [[ "$1" == "suspend" ]]; then
    info "[$(date)]: SUSPEND-TO-RAM REQUESTED: initiating via systemd..." $DKLOG
    systemctl suspend
  elif [[ "$1" == "hibernate" ]]; then
    info "[$(date)]: HIBERNATE ACTION REQUESTED: initiating via systemd..." $DKLOG
    systemctl hibernate
  else
    error "[$DATE]: Unknown action requested. Execution aborted" $DKLOG
    return -1
  fi
}

# massively kill stray process instances (polybar, conky....)
function nuke() {
  PROCTOKILL=${1}
  # clean up running polybar instances
  killall -q $PROCTOKILL
  stray_process_list=$(pgrep -u $UID -x $PROCTOKILL)
  # Terminate already running bar instances
  if [ "$stray_process_list" != "" ] ; then
      for i in ${stray_process_list} ; do
          # go brutal now.
          kill -9 $i
      done
  fi
  # wait...
  while pgrep -u $UID -x $PROCTOKILL >/dev/null; do sleep 1; done
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
}

# given a window id, get the corresponding screen id
function map_wid_to_desktop() {
  WID=$1

  SCREENID=`xprop -id $WID | awk -F= '/_NET_WM_DESKTOP/ { print $2 }'`
  test_str_empty $SCREENID && return 1

  echo $SCREENID;
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
}

# checks the fullscreen property bit for the specified window
function window_is_fullscreen() {
  WIN=$1

  FS_BIT=`xprop -id $WIN _NET_WM_STATE|awk '/_NET_WM_STATE_FULLSCREEN/ {print $1}'`
  test_str_empty $FS_BIT && return 1 # NOT FULLSCREEN
  return 0 # FULLSCREEN
}

