#!/bin/bash

OPTS="-a \"@\" -b -g -m -n -s"
COMMAND="/usr/bin/surf"

$COMMAND $OPTS $1 && rm -Rf $HOME/.surf
