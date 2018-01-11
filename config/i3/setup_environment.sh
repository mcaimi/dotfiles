#!/bin/bash
# setup keyboard layout
setxkbmap -layout "it"

# load Xresources
xrdb -all $HOME/.Xresources

# startup dunst
dunst &

# start compton compositor
compton --config $HOME/.config/compton.conf -b

