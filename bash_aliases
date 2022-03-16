#!/bin/bash

# aliases for modern commands
alias ll='ls -l'
alias cat='bat'
alias pst='procs -t'
alias top='gtop'
alias cw='wal -n -s -t -e'

# misc os aliases
alias grep='grep --color=auto'
alias vim='nvim'
alias pastebin='curl -F c=@- https://ptpb.pw/'
alias pict="feh --draw-filename --draw-exif -g 1280x800 "
alias mount="mount | column -t"
alias vsh="virsh -c qemu:///system"

# pacman quick shortcuts
alias pacman='sudo pacman'
alias pkgsearch='pacman -Ss'
alias pkginstall='sudo pacman -U'
alias pkgqry="pacman -Qq|sk-tmux --preview='pacman -Qi {}' --reverse --prompt='PACMAN QUERY> ' --header='Query for installed packages...'"

# GIT shortcuts
alias gl="git log"
alias ga="git add"
alias gs="git status"
alias gsu="git status -uno"
alias gp="git push"
alias gpl="git pull"
alias gco="git commit"
alias gcm="git commit -S -m"

# custom scripts
alias s3b="~/Work/Scripts/backup.sh"

# cloud
alias k="kubectl"
alias ap="ansible-playbook"
alias t="terraform"

# VPN definitions
[ -e $HOME/Work/dotfiles/aliases-vpn ] && source $HOME/Work/dotfiles/aliases-vpn

