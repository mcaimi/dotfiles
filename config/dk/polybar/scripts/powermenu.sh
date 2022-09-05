#!/usr/bin/env bash
uptime=$(uptime -p | sed -e 's/up //g')
rofi_command="dmenu -l 15 -bw 2"

# Options
shutdown="Shutdown"
reboot="Restart"
lock="Lock"
logout="Logout"

# Confirmation
confirm_exit() {
    dmenu -p "Are You Sure? (y|n) : "
}

# Variable passed to rofi
options="$lock\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime")"
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
