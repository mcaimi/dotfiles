#!/bin/bash
declare -A APPLETS
APPLETS=(["NETWORKMANAGER"]="nm-applet" ["FIREWALL"]="firewall-applet")

# let i3 load polybar completely...
sleep 2

for applet in ${APPLETS[@]};
do
  #cleanup if necessary...
  pkill -u $UID $applet
  $applet &
done
