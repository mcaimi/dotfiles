#!/usr/bin/env bash
set -eu

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

# aux functions
function disable_dpms() {
  xset dpms 0 0 0
}

# Requires i3lock-color from AUR
[[ -z "$(pgrep i3lock)" ]] || exit
trap disable_dpms HUP INT TERM

# enable dpms
xset +dpms dpms $STANDBY_TIMEOUT $SUSPEND_TIMEOUT $SHUTDOWN_TIMEOUT
xset s blank

# launch xclock and blank screen
i3lock -e -f -B=$BLUR_RADIUS -k --timefont=$TIMEFONT --timesize=$TIMESIZE --timecolor=$FONTCOLOR --timepos="$CLOCKPOS" --datefont=$DATEFONT --datesize=$DATESIZE --datecolor=$FONTCOLOR --indpos="$INDPOS" --indicator --radius=$INDRADIUS
xset s activate

# screen unlocked, disable dpms
disable_dpms
