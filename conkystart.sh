#!/bin/bash

# source helper library
source $HOME/.config/i3scripts/helper.sh

# let i3 load all xresources
sleep 3

# kill running conkies
nuke conky

# conky network interfaces HUD
conky -c ${HOME}/Work/dotfiles/conkyrc-network -d

# conky network interfaces HUD for bridges and vpn
conky -c ${HOME}/Work/dotfiles/conkyrc-network2 -d

# start conky HUD
conky -c ${HOME}/Work/dotfiles/conkyrc-archlinux -d

# conky rss info panel
conky -c ${HOME}/Work/dotfiles/conkyrc-info -d

# process panel
conky -c ${HOME}/Work/dotfiles/conkyrc-processpanel -d

