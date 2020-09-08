#!/bin/bash

OPTS="-a \"@\" -b -g -a -m -p -n"
COMMAND="/usr/bin/surf"

$COMMAND $OPTS $1 && rm -Rf $HOME/.surf
