#!/bin/bash

OPTS="-fs 11 +ls"
COMMAND="/usr/bin/w3m"

xterm $OPTS -e $COMMAND $1
