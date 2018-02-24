#!/bin/bash

# source helper library
source $HOME/.config/i3scripts/helper.sh

# let i3 load all xresources
sleep 3

# kill running conkies
nuke conky

# conky network interfaces HUD
#conky -c /home/marco/.conkyrc-network -d

# conky network interfaces HUD for bridges and vpn
#conky -c /home/marco/.conkyrc-network2 -d

# start conky HUD
conky -c /home/marco/.conkyrc-archlinux -d

# conky network interfaces HUD for bridges and vpn
#conky -c /home/marco/.conkyrc-info2 -d

# process panel
#conky -c /home/marco/.conkyrc-processpanel -d

