#!/usr/bin/env bash

dir="~/.config/rofi/"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/powermenu.rasi -xoffset -2 -yoffset 30 -location 3"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
logout=" Logout"

# Confirmation
confirm_exit() {
  rofi -dmenu\
    -i\
    -no-fixed-num-lines\
    -p "Are You Sure? (y|n) : "\
    -theme $dir/confirm.rasi
}

# Variable passed to rofi
options="$lock\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
      ans=$(confirm_exit &)
      if [[ $ans == "y" ]]; then
        systemctl poweroff
      elif [[ $ans == "n" ]]; then
        exit 0
      fi
    ;;
    $reboot)
      ans=$(confirm_exit &)
      if [[ $ans == "y" ]]; then
        systemctl reboot
      elif [[ $ans == "n" ]]; then
        exit 0
      fi
    ;;
    $lock)
      dm-tool lock
    ;;
    $logout)
      ans=$(confirm_exit &)
      if [[ $ans == "y" ]]; then
        i3-msg exit
      elif [[ $ans == "n" ]]; then
        exit 0
      fi
    ;;
esac
