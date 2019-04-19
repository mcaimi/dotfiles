#!/bin/bash

# some more ls aliases
alias ll='ls -l'

# misc os aliases
alias grep='grep --color=auto'
alias vim='nvim'
alias pastebin='curl -F c=@- https://ptpb.pw/'
alias pict="feh --draw-filename --draw-exif -g 1280x800 "
alias mount="mount | column -t"

# pacman quick shortcuts
alias pacman='sudo pacman'
alias pkgsearch='pacman -Ss'
alias pkginstall='sudo pacman -U'
alias pkgqry="pacman -Qq|sk-tmux --preview='pacman -Qi {}' --reverse --prompt='PACMAN QUERY> ' --header='Query for installed packages...'"

# GIT shortcuts
alias gl="git log"
alias gs="git status"
alias gsu="git status -uno"
alias gp="git push"

# custom scripts
alias s3b="~/Work/Scripts/backup.sh"

# VPN definitions
[ -e $HOME/Work/dotfiles/aliases-vpn ] && source $HOME/Work/dotfiles/aliases-vpn

