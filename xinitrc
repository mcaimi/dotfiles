#!/bin/sh
# vim:ts=4:sw=4:expandtab

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -all ~/.Xresources

xset s off
xset -dpms
xset s noblank

xset r rate 200 20

setxkbmap it #-option 'compose:ralt'
xmodmap -e 'clear lock'
xmodmap -e 'keycode 66 = Hyper_L'

#randr --output eDP-1 --primary
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)

exec dwm
