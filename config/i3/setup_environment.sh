#!/bin/bash
#
# Initial i3 desktop manager boot script
# everything related to the initial state of the desktop 
# is set up here

# load function library
source $HOME/.config/i3scripts/helper.sh

# setup keyboard layout
info "[$(date)]: Loading keyboard layout (IT).." $I3LOG
setxkbmap -layout "it"

# load Xresources
info "[$(date)]: Merging Xresources into the XRDB.." $I3LOG
xrdb -merge $HOME/.Xresources; wal -s -n -i ${I3ENV["wallpaper"]}

# startup dunst
info "[$(date)]: Starting up DUNST..." $I3LOG
dunst &

# start compton compositor
info "[$(date)]: Starting up COMPTON.." $I3LOG
compton --config $HOME/.config/compton.conf -b

# start unclutter
#info "[$(date)]: Starting up XIDLEHOOK.." $I3LOG
#xidlehook --time 10 --timer $HOME/.config/i3lock/i3lock.sh --notify 60 --notifier "notify-send \"XIdleHook is about to lock desktop in 60 sec..\"" --canceller "notify-send \"XIdleHook cancelled by user action.\"" --not-when-audio &

# start xiccd if needed
info "[$(date)]: Checking for XICCD..." $I3LOG
pgrep xiccd
if is_not_zero $?; then 
  info "[$(date)]: Startin up XICCD for display :0..." $I3LOG
  /usr/bin/xiccd -d :0 &
else
  info "[$(date)]: Killing old XICCD process..." $I3LOG
  pkill xiccd
  info "[$(date)]: Startin up XICCD for display :0..." $I3LOG
  /usr/bin/xiccd -d :0 &
fi

# setup ssh keyring
info "[$(date)]: Setting up SSH keyring..." $I3LOG 
for keyname in ${KEYS[@]}; do
  key_load $keyname 
done

# setup wallpaper
feh --bg-fill ${I3ENV["wallpaper"]}
