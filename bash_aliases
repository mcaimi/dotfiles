#!/bin/bash

# some more ls aliases
alias ll='ls -l'
alias catp='bat -p'
alias grep='grep --color=auto'
alias vim='nvim'
alias s3b="~/Work/Scripts/backup.sh"
alias pict="feh --draw-filename --draw-exif -g 1280x800 "
alias mount="mount | column -t"
alias cat="bat"

# Pacman and yaourt aliases
alias pacman='sudo pacman'
alias pkgsearch='pacman -Ss'
alias pkginstall='sudo pacman -U'
alias pkgqry="pacman -Qq|fzf --preview='pacman -Qi {}' --prompt='PACMAN> ' --header='Type to search for installed packages.'"

# miscellaneous aliases
alias pastebin='curl -F c=@- https://ptpb.pw/'
source $HOME/Work/dotfiles/alias_locali

# Git related aliases
alias gl="git log"
alias gs="git status"
alias gsu="git status -uno"
alias gp="git push"

# VPN and connectivity
alias protonvpn="sudo openvpn --config $HOME/Work/dotfiles/nl-02.protonvpn.com.tcp.ovpn --log /var/log/openvpn-protonmail.log --daemon"

