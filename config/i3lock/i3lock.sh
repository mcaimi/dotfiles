#!/usr/bin/env bash
set -eu

# in seconds
ONEMINUTE=60
STANDBY_TIMEOUT=$(( $ONEMINUTE * 20 ))
SUSPEND_TIMEOUT=$(( $ONEMINUTE * 60 ))
SHUTDOWN_TIMEOUT=$(( $ONEMINUTE * 0 ))

TIMEFONT="iosevka-term-regular"
DATEFONT="iosevka-term-regular"
FONTCOLOR="FFFFFFFF"
TIMESIZE=48
DATESIZE=24

function disable_dpms() {
  xset dpms 0 0 0
}

# Requires i3lock-color form AUR
[[ -z "$(pgrep i3lock)" ]] || exit
trap disable_dpms HUP INT TERM

# enable dpms
xset +dpms dpms $STANDBY_TIMEOUT $SUSPEND_TIMEOUT $SHUTDOWN_TIMEOUT
xset s blank

# launch xclock and blank screen
i3lock -e -f -B=30 -k --timefont=$TIMEFONT --timesize=$TIMESIZE --timecolor=$FONTCOLOR --timepos="150:800" --datefont=$DATEFONT --datesize=$DATESIZE --datecolor=$FONTCOLOR --indpos="1600:150"
xset s activate

# screen unlocked, disable dpms
disable_dpms
