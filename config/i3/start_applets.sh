#!/bin/bash
declare -A APPLETS

# networkmanager applet was replaced by the infinitely superior networkmanager_dmenu AUR package
#APPLETS=(["NETWORKMANAGER"]="nm-applet" ["FIREWALL"]="firewall-applet" ["MEGASYNC"]="megasync")
APPLETS=(["FIREWALL"]="firewall-applet" ["MEGASYNC"]="megasync")

# let i3 load polybar completely...
sleep 2

for applet in ${APPLETS[@]};
do
  #cleanup if necessary...
  pkill -u $UID $applet
  $applet &
done
