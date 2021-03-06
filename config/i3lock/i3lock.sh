#!/usr/bin/env bash
set -eu

# is dm-tool installed?
if [[ -e $(which dm-tool) ]]; then
  dm-tool lock
else
  source $HOME/.config/i3scripts/helper.sh
  # in seconds
  ONEMINUTE=60
  STANDBY_TIMEOUT=$(( $ONEMINUTE * 20 ))
  SUSPEND_TIMEOUT=$(( $ONEMINUTE * 60 ))
  SHUTDOWN_TIMEOUT=$(( $ONEMINUTE * 0 ))

  # resolution helper
  RESHELPER=$HOME/.config/i3scripts/deskres.bin
  WIDTH=`$RESHELPER -i 0 -w`
  HEIGHT=`$RESHELPER -i 0 -h`

  # i3lock-color params
  TIMEFONT="iosevka-term-regular"
  DATEFONT="iosevka-term-regular"
  FONTCOLOR="FFFFFFFF"
  TIMESIZE=48
  DATESIZE=24
  BLUR_RADIUS=60
  INDRADIUS=90
  CLOCKPOS="$(( $WIDTH / 2 )):$(( ($HEIGHT / 2) - 2*$INDRADIUS ))"
  INDPOS="$(( $WIDTH / 2 )):$(( ($HEIGHT / 2) + 2*$INDRADIUS ))"

  # Requires i3lock-color from AUR
  [[ -z "$(pgrep i3lock)" ]] || exit
  trap disable_dpms HUP INT TERM

  # enable dpms
  xset +dpms dpms $STANDBY_TIMEOUT $SUSPEND_TIMEOUT $SHUTDOWN_TIMEOUT

  # launch xclock and blank screen
  #i3lock -e -f -B=$BLUR_RADIUS -k --timefont=$TIMEFONT --timesize=$TIMESIZE --timecolor=$FONTCOLOR --timepos="$CLOCKPOS" --datefont=$DATEFONT --datesize=$DATESIZE --datecolor=$FONTCOLOR --indpos="$INDPOS" --indicator --radius=$INDRADIUS
  i3lock --ignore-empty-password -f -B=$BLUR_RADIUS --indpos="$INDPOS" --indicator --radius=$INDRADIUS
  xset s blank && xset s on && xset s 10

  # screen unlocked, disable dpms
  disable_dpms
fi
