#!/bin/bash

# some more ls aliases
alias ll='ls -l'
alias grep='grep --color=auto'
alias pacman='sudo pacman'
alias pkgsearch='pacman -Ss'
alias pkginstall='sudo pacman -U'
alias pkgqry='pacman -Q'
alias vim='nvim'
#alias pastebin="curl -F 'sprunge=<-' http://sprunge.us"
alias pastebin='curl -F c=@- https://ptpb.pw/'
alias gl="git log"
alias gs="git status"
alias gsu="git status -uno"
alias gp="git push"
alias s3b="~/Work/Scripts/backup.sh"
alias pict="feh --draw-filename --draw-exif -g 1280x800 "
alias fwifi="nmcli con up 42b482de-854a-4d0b-844c-ba07911bbcd0 --ask"
alias fvpn="nmcli con up f583903e-2262-455d-8cb7-ceff09eaea8b --ask"
alias protonvpn="sudo openvpn --config $HOME/Work/dotfiles/nl-free-02.protonvpn.com.tcp443.ovpn --daemon"
alias mount="mount | column -t"

# dockerized programs
alias sandfox="docker run --rm -d -v /var/run/dbus/:/var/run/dbus/ -v /run/user/1001/pulse/:/run/user/1001/pulse/ -v /home/marco/.mozilla:/home/firefox/.mozilla -v /home/marco/Downloads:/home/firefox/Downloads -v /home/marco/.pulse-cookie:/home/firefox/.pulse-cookie -v /tmp/.X11-unix:/tmp/.X11-unix --name sandfox --hostname sandfox.midgar.net -v /dev/shm:/dev/shm -e DISPLAY=:0 sandbox/firefox:latest"
alias trashfox="docker run --rm -d --name trashfox --hostname trashfox.midgar.net -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=:0 sandbox/firefox:latest"
