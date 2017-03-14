#!/bin/bash

# conky network interfaces HUD
conky -c /home/marco/.conkyrc-network -d
# conky network interfaces HUD for bridges and vpn
conky -c /home/marco/.conkyrc-network2 -d
# start conky HUD
conky -c /home/marco/.conkyrc-archlinux -d

