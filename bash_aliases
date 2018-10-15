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
alias fvpn="pass Email/fastcloud-vpn| sudo openconnect --config=/home/marco/.config/fastcloud-vpn vpn.fastcloud.it"
alias protonvpn="sudo openvpn --config $HOME/Work/dotfiles/nl-free-02.protonvpn.com.tcp443.ovpn --daemon"
